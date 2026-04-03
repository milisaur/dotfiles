{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../../modules/common.nix
  ];

  networking.hostName = "spinosaurus";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "mili" ];

  programs.thunderbird.enable = true;

  programs.steam = {
    enable = true;
  };

  services.resolved.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gparted
    vulkan-tools
    vim
    wget
  ];
}
