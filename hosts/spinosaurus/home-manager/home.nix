{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ../../../modules/home/dev.nix
    ../../../modules/home/gpg.nix
    ../../../modules/home/r.nix
    ../../../modules/home/zsh.nix
    ../../../modules/home/nvim.nix
    ../../../modules/home/kitty.nix
    ../../../modules/home/hyprland/base.nix
    ../../../modules/home/hyprland/spinosaurus.nix
    ../../../modules/home/waybar.nix
    ../../../modules/home/fonts.nix
    ../../../modules/home/rofi.nix
  ];

  home.username = "mili";
  home.homeDirectory = "/home/mili";
  home.stateVersion = "25.11"; # Please read the comment before changing.

  home.sessionVariables = {
    TERMINAL = "kitty";
  };

  programs.home-manager.enable = true;
}
