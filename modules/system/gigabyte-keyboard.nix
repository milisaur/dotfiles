{
  config,
  lib,
  pkgs,
  ...
}: let
  gigactlRev = "79ad2d523425db266ef488c93719dd75a268ef8f";

  fetchGigactl = file: hash:
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/smairio/gigactl/${gigactlRev}/${file}";
      inherit hash;
    };

  gkbdSource = pkgs.runCommand "gigactl-gkbd-source" {} ''
    mkdir -p "$out"
    install -m 755 ${fetchGigactl "gkbd" "sha256-wp8B7oRZSLWh9abGC4QDrJWuSjMotCcg6p+5mEhRi+s="} "$out/gkbd"
    install -m 644 ${fetchGigactl "gigactl-cli-lib.sh" "sha256-zq5W0EFOspYoqHe3i0oI0jeb8OTuUKQXdfPxyXqzCwc="} "$out/gigactl-cli-lib.sh"
  '';

  runtimePath = lib.makeBinPath (with pkgs; [
    bash
    coreutils
    gawk
    gnugrep
    nbfc-linux
    systemd
    util-linux
  ]);

  gkbd = pkgs.writeShellScriptBin "gkbd" ''
    set -euo pipefail
    export GKBD_EC_PROBE="${pkgs.nbfc-linux}/bin/ec_probe"
    export GKBD_STATE_DIR="/var/lib/gkbd"
    export PATH="${runtimePath}:$PATH"

    if [ "$(${pkgs.coreutils}/bin/id -u)" -ne 0 ]; then
      exec ${config.security.wrapperDir}/sudo ${pkgs.coreutils}/bin/env \
        GKBD_EC_PROBE="$GKBD_EC_PROBE" \
        GKBD_STATE_DIR="$GKBD_STATE_DIR" \
        PATH="$PATH" \
        ${pkgs.bash}/bin/bash ${gkbdSource}/gkbd "$@"
    fi

    ${pkgs.bash}/bin/bash ${gkbdSource}/gkbd "$@"

    if [ "$#" -gt 0 ]; then
      case "$1" in
        off)
          ${pkgs.coreutils}/bin/mkdir -p "$GKBD_STATE_DIR"
          printf 'off\n' > "$GKBD_STATE_DIR/enabled"
          ;;
        status|apply|help|-h|--help)
          ;;
        *)
          ${pkgs.coreutils}/bin/mkdir -p "$GKBD_STATE_DIR"
          printf 'on\n' > "$GKBD_STATE_DIR/enabled"
          ;;
      esac
    fi
  '';

  restoreKeyboard = ''
    if [ -f /var/lib/gkbd/enabled ] && [ "$(${pkgs.coreutils}/bin/cat /var/lib/gkbd/enabled)" = "off" ]; then
      ${gkbd}/bin/gkbd off
    elif [ -f /var/lib/gkbd/state ]; then
      ${gkbd}/bin/gkbd apply
    else
      ${gkbd}/bin/gkbd blue
    fi
  '';
in {
  boot.kernelModules = ["ec_sys"];

  boot.extraModprobeConfig = ''
    options ec_sys write_support=1
  '';

  environment.systemPackages = [gkbd];

  systemd.services.gigabyte-keyboard-restore = {
    description = "Restore GIGABYTE G5 keyboard backlight on boot";
    wantedBy = ["multi-user.target"];
    after = ["systemd-modules-load.service" "dbus.service"];
    serviceConfig.Type = "oneshot";
    script = restoreKeyboard;
  };

  powerManagement.resumeCommands = ''
    ${pkgs.coreutils}/bin/sleep 1
    ${restoreKeyboard}
  '';
}
