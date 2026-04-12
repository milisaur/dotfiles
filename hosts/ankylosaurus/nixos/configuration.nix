# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
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

  networking.networkmanager.enable = true;

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = ["mili"];

  programs.thunderbird.enable = true;
  programs.zsh.enable = true;
  users.users.mili.shell = pkgs.zsh;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];

  services.dbus.enable = true;

  programs.steam = {
    enable = true;
  };

  services.murmur = {
    enable = true;
    openFirewall = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam.gamescopeSession.enable = true;

  services.resolved.enable = true;

  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    git
    gparted
    vim
    wget
    vulkan-tools

    waybar
    wl-clipboard
    grim
    slurp

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
}
