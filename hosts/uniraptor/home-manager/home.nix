{ inputs, ... }:

{
  imports = [
    ../../../modules/home/hyprland/uniraptor.nix
    ../../../modules/home/hyprland/base.nix
    ../../../modules/home/waybar.nix
  ];

  home.username = "mili";
  home.homeDirectory = "/home/mili";

  home.stateVersion = "25.11";

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  programs.home-manager.enable = true;


}

