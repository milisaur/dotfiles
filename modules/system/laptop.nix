{
  config,
  pkgs,
  lib,
  ...
}: let
  user = "mili";

  applyLaptopPower = pkgs.writeShellScriptBin "apply-laptop-power" ''
    set -euo pipefail

    sleep 3

    BAT="$(${pkgs.upower}/bin/upower -e | ${pkgs.gnugrep}/bin/grep BAT | ${pkgs.coreutils}/bin/head -1)"

    STATE="$(${pkgs.upower}/bin/upower -i "$BAT" \
      | ${pkgs.gnugrep}/bin/grep "state:" \
      | ${pkgs.coreutils}/bin/cut -d: -f2 \
      | ${pkgs.coreutils}/bin/tr -d ' ')"

    STATE_FILE="/tmp/laptop-power-state-system"

    OLD_STATE=""
    if [ -f "$STATE_FILE" ]; then
      OLD_STATE="$(${pkgs.coreutils}/bin/cat "$STATE_FILE")"
    fi

    if [ "$STATE" = "$OLD_STATE" ]; then
      exit 0
    fi

    echo "$STATE" > "$STATE_FILE"

    if [ "$STATE" = "discharging" ]; then
      ${pkgs.tlp}/bin/tlp bat || true
      ${pkgs.brightnessctl}/bin/brightnessctl set 50% || true
    else
      ${pkgs.tlp}/bin/tlp ac || true
      ${pkgs.brightnessctl}/bin/brightnessctl set 80% || true
    fi
  '';

  powerStatus = pkgs.writeShellScriptBin "power-status" ''
    BAT="$(${pkgs.upower}/bin/upower -e | ${pkgs.gnugrep}/bin/grep BAT | ${pkgs.coreutils}/bin/head -1)"

    echo "──────────────────────────────"
    echo "Laptop Status"
    echo "──────────────────────────────"

    echo
    echo "Power:"
    ${pkgs.upower}/bin/upower -i "$BAT" \
      | ${pkgs.gnugrep}/bin/grep -E "state|percentage|energy-rate|time to empty"

    echo
    echo "CPU:"
    echo -n "Governor: "
    ${pkgs.coreutils}/bin/cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo -n "EPP:      "
    ${pkgs.coreutils}/bin/cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
    echo -n "Turbo:    "
    if [ "$(${pkgs.coreutils}/bin/cat /sys/devices/system/cpu/intel_pstate/no_turbo)" = "1" ]; then
      echo "off"
    else
      echo "on"
    fi

    echo
    echo "NVIDIA:"
    echo -n "Runtime:  "
    ${pkgs.coreutils}/bin/cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status 2>/dev/null || true
    echo -n "State:    "
    ${pkgs.coreutils}/bin/cat /sys/bus/pci/devices/0000:01:00.0/power_state 2>/dev/null || true

    echo
    echo "Display:"
    ${pkgs.brightnessctl}/bin/brightnessctl 2>/dev/null \
      | ${pkgs.gnugrep}/bin/grep "Current brightness" || true

    ${pkgs.hyprland}/bin/hyprctl monitors 2>/dev/null \
      | ${pkgs.gnugrep}/bin/grep -E "Monitor|@[0-9]" || true

    echo
    echo "Top CPU:"
    ${pkgs.procps}/bin/ps -eo pid,comm,%cpu,%mem --sort=-%cpu | ${pkgs.coreutils}/bin/head -8

    echo "──────────────────────────────"
  '';
in {
  environment.systemPackages = with pkgs; [
    brightnessctl
    upower
    gnugrep
    coreutils
    procps
    powerStatus
    applyLaptopPower
  ];

  systemd.services.laptop-power-apply = {
    description = "Apply system laptop AC/battery power profile";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${applyLaptopPower}/bin/apply-laptop-power";
    };
  };

  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="power_supply", RUN+="${pkgs.systemd}/bin/systemctl start laptop-power-apply.service"
    ACTION=="change", SUBSYSTEM=="power_supply", RUN+="${pkgs.systemd}/bin/systemctl --machine=${user}@.host --user start battery-hypr.service"
  '';
}
