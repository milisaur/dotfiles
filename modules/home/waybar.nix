{ ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "cpu" "memory" "network" "battery" ];

        clock = {
          format = "{:%H:%M}";
        };
      };
    };

    style = ''
      * {
        font-family: sans-serif;
        font-size: 13px;
      }

      window#waybar {
        background: rgba(30, 30, 30, 0.9);
        color: white;
      }
    '';
  };
}
