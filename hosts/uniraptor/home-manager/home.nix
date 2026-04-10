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
