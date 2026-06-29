{pkgs, ...}: let
  batteryHypr = pkgs.writeShellScriptBin "battery-hypr" ''
    BAT="$(${pkgs.upower}/bin/upower -e | grep BAT | head -1)"
    STATE="$(${pkgs.upower}/bin/upower -i "$BAT" | grep "state:" | cut -d: -f2 | tr -d ' ')"

    if [ "$STATE" = "discharging" ]; then
      hyprctl keyword monitor "eDP-1,1920x1080@60,auto,1"
      hyprctl keyword animations:enabled 0
      hyprctl keyword decoration:blur:enabled false
      notify-send "🔋 Battery mode" "60 Hz · animations off · blur off"
    else
      hyprctl keyword monitor "eDP-1,1920x1080@144,auto,1"
      hyprctl keyword animations:enabled 1
      hyprctl keyword decoration:blur:enabled true
      notify-send "🔌 AC mode" "144 Hz · animations on · blur on"
    fi
  '';
in {
  home.packages = with pkgs; [
    upower
    libnotify
    batteryHypr
  ];

  systemd.user.services.battery-hypr = {
    Unit.Description = "Apply Hyprland battery/AC settings";

    Service = {
      Type = "oneshot";
      ExecStart = "${batteryHypr}/bin/battery-hypr";
    };
  };
}
