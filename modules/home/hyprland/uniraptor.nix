{ config, pkgs, ... }:
{
wayland.windowManager.hyprland = {
  enable = true;

  settings = {
    monitor = [
    ", preferred, auto, 1"
    ];

    input = {
      kb_layout = "de";
      follow_mouse = 1;
    };

    exec-once = [
      "waybar"
      "mako"
      "nm-applet"
      "hyprpaper"
    ];

    "$mainMod" = "SUPER";

    bind = [
      "$mainMod, Q, exec, kitty"
      "$mainMod, E, exec, dolphin"
      "$mainMod, R, exec, rofi -show drun"
      "$mainMod, C, killactive"
    ];
   };
  };
 }
