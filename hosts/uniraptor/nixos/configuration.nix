{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../../modules/common.nix
  ];

  networking.hostName = "uniraptor"; # Define your hostname.

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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.thunderbird.enable = true;

  programs.zsh.enable = true;

  users.users.mili.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    kitty
    rofi
    waybar
    hyprpaper
    mako
    networkmanagerapplet
    git
    vim
    wget
    neovim
    wl-clipboard
    grim
    slurp
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
