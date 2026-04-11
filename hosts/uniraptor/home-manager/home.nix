{ inputs, ... }:

{
  imports = [
    ../../../modules/home/hyprland/uniraptor.nix
    ../../../modules/home/hyprland/base.nix
    ../../../modules/home/waybar.nix
    ../../../modules/home/hyprland/wallpaper.nix
    ../../../modules/home/zsh.nix
    ../../../modules/home/kitty.nix
    ../../../modules/home/fonts.nix
  ];

  home.username = "mili";
  home.homeDirectory = "/home/mili";

  home.stateVersion = "25.11";

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  programs.home-manager.enable = true;


}

