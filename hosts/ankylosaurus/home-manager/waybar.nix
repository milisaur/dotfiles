{config, pkgs, lib, ...}:

{
    imports = [
        ./style.nix
        ];


    programs.waybar = {
        enable = true;

        settings.main = {

            layer = "top"; #Waybar at top layer
            #output = "DP-3";
            position = "top"; # Waybar position (top|bottom|left|right)
            height = 35; # Waybar height (to be removed for auto height)
            spacing = 4; # Gaps between modules (4px)
            margin-top = 1;
            margin-bottom = 1;
            margin-left = 1;
            margin-right = 1;
            fixed-center = true;

            modules-left = [
                "hyprland/window"
                "custom/divider"
                "hyprland/submap"
                "custom/divider"
                "wlr/taskbar"
            ];

            modules-center = [
                "custom/distro"
                "custom/divider"
                "hyprland/workspaces"
            ];

            modules-right = [
                "memory"
                "custom/divider"
                "cpu"
                "custom/divider"
                "custom/gpu"
                "custom/divider"
                "pulseaudio"
                "custom/divider"
                "clock"
                "custom/divider"
                "network"
                "custom/divider"
                "custom/notification"
                "custom/divider"
                "custom/power"
            ];

            "hyprland/workspaces" = {
                all-outputs = true;
                format = "{name}: {icon}";
                format-icons = {
                    "active" = "";
                    "default" = "";
                };
            };

            "custom/divider" = {
                format = " | ";
                interval = "once";
                tooltip = false;
            };

            pulseaudio = {
                format-muted = "🔇";
                on-click = "pavucontrol";
            };

            memory = {
                format =  "{}% ";
                tooltip = false;
            };

            cpu = {
                format = "{usage}% ";
                tooltip = false;
            };

            "custom/gpu" = {
                exec = "cat /sys/class/hwmon/hwmon1/device/gpu_busy_percent";
                format = "GPU: {}%";
                return-type = "";
                tooltip = false;
                on-click = "gpu-viewer";
            };

            clock = {
                format = "  {:%H:%M    %d/%m} ";
                tooltip-format =  ''<tt><small>{calendar}</small></tt>'';
                on-click = "kitty -e calcure";
            };

            network = {
                format-ethernet = "{ipaddr}/{cidr}";
                format-disconnected = "Disconnected ⚠";
                tooltip-format = "{ifname} via {gwaddr}";

            };


            "custom/power" = {
                format = "⏻ ";
                tooltip = false;
                menu = "on-click";
                menu-file = "$HOME/.config/home-manager/power_menu.xml";
                menu-actions = {
                    "shutdown" = "shutdown now";
                    "suspend" = "systemctl suspend";
                    "reboot" = "systemctl reboot";
                    };
            };

            "hyprland/submap" = {
                format = "SubM: {}";
                max-length = 15;
                tooltip = false;
                always-on = true;
                default-submap = "Main";

            };

            "hyprland/window" = {
                rewrite = {
                    "title<(.* — )?Mozilla Firefox" =  "Firefox";
                    "mili@nixos:(.*)" = "kitty";
                    "(.*) - Discord" = "Discord";
                };
            };

            "custom/discord" = {
                format = "{icon}";
                format-icons = {
                    "default" = "";
                };
                on-click = "discordptb";

            };


            "custom/appmenu" = {
                format = "Menu {icon}";
                format-icon = "󰻀";
                rotate = 0;
                #on-click = soll rofi öffnen
            };

            "wlr/taskbar" = {

                format = "{icon}";
                tooltip = true;
                tooltip-format = "{title}";
                active-first = false;
                ignore-list = [
                #    "kitty"
                #    "org.kde.kate"
                #    "org.kde.dolphin"
                ];

                on-click = "activate";
                on-klick-middle = "close";

                rewrite = {
                    "(.*) - Discord" = "Discord";

                };
            };

            "custom/distro" = {
                format = "";
            };

             "custom/notification" = {
                tooltip = true;
                format = "<span size='16pt'>{icon}</span>";
                format-icons = {
                    notification = "󱅫";
                    none = "󰂜";
                    dnd-notification = "󰂠";
                    dnd-none = "󰪓";
                    inhibited-notification = "󰂛";
                    inhibited-none = "󰪑";
                    dnd-inhibited-notification = "󰂛";
                    dnd-inhibited-none = "󰪑";
                };

                return-type = "json";
                exec-if = "which swaync-client";
                exec = "swaync-client -swb";
                on-click = "swaync-client -t -sw";
                on-click-right = "swaync-client -d -sw";
                escape = true;
            };


    };
};










}
