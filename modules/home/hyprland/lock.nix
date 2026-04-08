{ pkgs, ... }:

let
  wallpaper = ../../../assets/wallpapers/main.jpg;
in
{
  home.packages = with pkgs; [
    hyprlock
  ];

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = ${wallpaper}
      blur_passes = 3
      blur_size = 10
    }

    label {
      monitor =
      text = $TIME
      font_size = 60
      color = rgba(255,255,255,1)
      position = 0, 120
      halign = center
      valign = center
    }

    input-field {
      monitor =
      size = 300, 55
      outline_thickness = 2

      outer_color = rgba(255,255,255,0.2)
      inner_color = rgba(0,0,0,0.4)
      font_color = rgba(255,255,255,1)

      placeholder_text = <i>Password</i>
      fade_on_empty = false

      position = 0, -40
      halign = center
      valign = center
    }
  '';
}
