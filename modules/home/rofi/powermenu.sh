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
