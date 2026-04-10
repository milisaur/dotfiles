{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "triceratops";

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  system.stateVersion = "25.11";
}
