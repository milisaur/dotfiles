{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ../../../modules/home/dev.nix
    ../../../modules/home/gpg.nix
    ../../../modules/home/r.nix
    ../../../modules/home/zsh.nix
    ../../../modules/home/nvim.nix
  ];

  home.username = "mili";
  home.homeDirectory = "/home/mili";
  home.stateVersion = "25.11"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
