{...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "DP-1,1920x1080@60,0x0,1"
      "DP-3,1920x1080@60,1920x0,1"
      "HDMI-A-1,1920x1080@60,3840x0,1"
      "DP-2,1680x1050@74.89,5760x0,1"
    ];

    workspace = [
      "1, monitor:DP-1, default:true"
      "2, monitor:DP-3, default:true"
      "3, monitor:HDMI-A-1, default:true"
      "4, monitor:DP-2, default:true"
    ];

    input = {
      kb_layout = "de";
      follow_mouse = 1;
    };

    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    bindl = [
      ",XF86AudioNext, exec, playerctl next"
      ",XF86AudioPause, exec, playerctl play-pause"
      ",XF86AudioPlay, exec, playerctl play-pause"
      ",XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
