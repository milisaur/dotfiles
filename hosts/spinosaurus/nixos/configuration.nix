{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../../modules/common.nix
    ../../../modules/sddm.nix
    ../../../modules/sddm-wayland.nix
    ../../../modules/plasma.nix
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
  ];
}
