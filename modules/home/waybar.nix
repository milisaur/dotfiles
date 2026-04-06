{ ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "network"
          "pulseaudio"
          "cpu"
          "memory"
          "battery"
          "tray"
        ];

        "hyprland/workspaces" = {
          disable-scroll = false;
          all-outputs = false;
        };

        clock = {
          format = "󱑆  {:%H:%M}";
          tooltip-format = "{:%A, %d.%m.%Y %H:%M}";
        };

        network = {
          format-wifi = "  {essid}";
          format-ethernet = "󰈀  Ethernet";
          format-disconnected = "󰖪  Offline";
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "nm-applet";  
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "󰝟  muted";
          format-icons = {
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";       
        };

        cpu = {
          format = "󰍛  {usage}%";
        };

        memory = {
          format = "󰘚  {}%";
        };

        battery = {
          format = "󰁹  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰂄  {capacity}%";
          format-warning = "󰁺  {capacity}%";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
     * {
       font-family: "JetBrainsMono Nerd Font";
       font-size: 13px;
       min-height: 0;
       border: none;
       border-radius: 0;
      }

      window#waybar {
        background: rgba(15, 15, 15, 0.88);
        color: #e6e6e6;
        margin: 6px 10px;
      }

      #workspaces {
       margin: 6px 8px;
      }

      #workspaces button {
       padding: 0 12px;
       margin: 0 5px;
       background: transparent;
       color: #bdbdbd;
       border-radius: 10px;
     }

      #workspaces button.active {
       background: rgba(255, 255, 255, 0.18);
       color: #ffffff;
     }

      #workspaces button:hover {
        background: rgba(255, 255, 255, 0.08);
        color: #ffffff;
      }

      #clock,
      #network,
      #pulseaudio,
      #cpu,
      #memory,
      #battery,
      #tray {
        margin: 6px 6px;
        padding: 0 16px;
        border-radius: 10px;
        background: rgba(255, 255, 255, 0.08);
     }

     #clock {
       font-weight: 600;
      }

      #battery.warning {
        color: #ffcc66;
      }

     #battery.critical {
        color: #ff6b6b;
      }

      #battery.charging {
        color: #8bd5ca;
      }

      tooltip {
        background: rgba(30, 30, 30, 0.95);
        color: #ffffff;
        border-radius: 8px;
        padding: 8px;
      }
    '';

  };
}
