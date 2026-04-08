{...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,preferred,0x0,1"
      "DP-2,preferred,1920x0,1"
    ];

    input = {
      kb_layout = "de";
      follow_mouse = 1;
    };
  };
}
