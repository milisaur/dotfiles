{ config, pkgs, ... }:

{
  home.username = "mili";
  home.homeDirectory = "/home/mili";

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    firefox
  ];
}

