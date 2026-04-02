file=$(find "$HOME/.config/hypr/wallpapers" -maxdepth 1 -type f | shuf -n 1)

hyprctl hyprpaper wallpaper DP-3,$file
hyprctl hyprpaper wallpaper HDMI-A-1,$file
