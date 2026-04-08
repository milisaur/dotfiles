{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    theme = ./rofi/theme.rasi;

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus";
      display-drun = "Apps";
      display-run = "Run";
      display-window = "Windows";
      drun-display-format = "{icon}  {name}";
      disable-history = false;
      hide-scrollbar = true;
      sidebar-mode = false;
    };
  };

  home.packages = [
    (pkgs.writeShellScriptBin "powermenu" ''
      options=" Lock\n⏾ Suspend\n Reboot\n Shutdown"

      choice=$(echo -e "$options" | rofi -dmenu -i -p "Power")
      [ -z "$choice" ] && exit 0

      confirm=$(echo -e "No\nYes" | rofi -dmenu -i -p "Confirm $choice?")
      [ "$confirm" != "Yes" ] && exit 0

      case "$choice" in
        *Lock) hyprlock ;;
        *Suspend) systemctl suspend ;;
        *Reboot) systemctl reboot ;;
        *Shutdown) systemctl poweroff ;;
      esac
    '')
  ];
}
