{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/common.nix
  ];

  networking.hostName = "uniraptor";

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  system.stateVersion = "25.11";
}
