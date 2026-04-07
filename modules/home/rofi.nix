{ ... }:

{
  programs.rofi = {
    enable = true;
    theme = ./rofi/theme.rasi;

    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus";
      display-drun = "Apps";
      display-run = "Run";
      display-window = "Windows";
      drun-display-format = "{icon}  {name}";
      disable-history = false;
      hide-scrollbar = true;
      sidebar-mode = false;
    };
  };
}
