{config, pkgs, lib, ...}:
let
  custom = {
    font = "MesloLG";
    font_size = "14px";
    font_weight = "normal";
    text_color = "#FBF1C7";
    background_0 = "#1D2021";
    background_1 = "#282828";
    border_color = "#A89984";
    red = "#CC241D";
    green = "#98971A";
    yellow = "#FABD2F";
    blue = "#458588";
    magenta = "#B16286";
    pink = "#ff00a9";
    cyan = "#689D6A";
    orange = "#D65D0E";
    orange_bright = "#FE8019";
    purple = "#9614D0";
    opacity = "1";
    indicator_height = "2px";
  };
in
{
  programs.waybar.style = with custom; ''
    * {
      border: ${purple};
      border-radius: 1px;
      padding: 1px;
      margin: 0;
      font-family: ${font};
      font-weight: ${font_weight};
      opacity: ${opacity};
      font-size: ${font_size};
    }

    window#waybar {
      background: #282828;
      border: 1px solid ${purple};
    }

    tooltip {
      background: ${background_1};
      border: 1px solid ${purple};
    }
    tooltip label {
      margin: 5px;
      color: ${text_color};
    }

    #workspaces {
      padding-left: 15px;
    }
    #workspaces button {
      color: ${text_color};
      padding-left:  5px;
      padding-right: 5px;
      margin-right: 10px;
    }

    #workspaces button.active {
      color: ${text_color};
    }

    #clock {
      color: ${text_color};
      background: ${background_1};
    }

    #pulseaudio {
      padding-left: 5px;
      padding-right: 5px;
      margin-right: 5px;
      color: ${text_color};
      background: ${background_1};
    }

    #pulseaudio {
      margin-left: 5px;
    }

    #network {
      color: ${text_color}
    }

    custom#power {
      color: ${text_color}

    }

    custom#divider {
      color: ${text_color}

    }


    custom#gpu {
      color: ${text_color}
    }

    #memory {
      color: ${text_color}
    }

    #cpu {
      color: ${text_color}
    }

  '';



}
