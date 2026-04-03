# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../../modules/common.nix
    ];

  networking.hostName = "ankylosaurus";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  programs.thunderbird.enable = true;

  environment.systemPackages = with pkgs;
    let
      rstudio-packages = rstudioWrapper.override {
        packages = with rPackages; [
          tidyverse
          sjPlot
        ];
      };
    in [
      bitwarden-desktop
      discord-ptb
      git
      gparted
      home-manager
      hyprpaper
      hyprshot
      kitty
      libreoffice
      libnotify
      lxqt.lxqt-policykit
      lutris
      mako
      networkmanagerapplet
      pavucontrol
      prismlauncher
      protonup-qt
      rofi
      rstudio-packages
      signal-desktop
      simple-scan
      spotify
      texliveSmall
      texstudio
      tor-browser
      vulkan-tools
      vscode
      waybar
      wine
      zsh-powerlevel10k
    ];

  programs.steam = {
    enable = true;
  };

  services.resolved.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
}
