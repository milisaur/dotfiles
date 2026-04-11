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

   };
  };
 }
