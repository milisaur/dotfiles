{pkgs, ...}: let
  wallpaper = ../../../assets/wallpapers/main.jpg;
in {
  home.packages = with pkgs; [
    hyprpaper
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    wallpaper {
      monitor =
      path = ${wallpaper}
      fit_mode = cover
    }

    splash = false
  '';
}
