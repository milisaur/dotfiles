{ pkgs, ... }:

let
  wallpaper = ../../../assets/wallpapers/main.jpg;
in

{
  home.packages = with pkgs; [
    hyprpaper
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ${wallpaper}
    wallpaper = ,${wallpaper}
    splash = false
  '';
}
