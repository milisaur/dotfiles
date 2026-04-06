{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;

    settings = {
      font_size = 12;
      enable_audio_bell = false;
      confirm_os_window_close = 0;

      window_padding_width = 8;

      background_opacity = 0.95;

      scrollback_lines = 10000;
    };
  };
}
