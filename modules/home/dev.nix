{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    git
    git-crypt
    gnupg
    nano
    zsh
    
    yazi
    rofi
    mako
    networkmanagerapplet

    libnotify

    curl
    wget
    unzip

    ripgrep
    fd
    fzf
    bat
    btop
    lazygit

    go
    gopls
    gotools

    python3
    pyright

    direnv
    nix-direnv

    playerctl
    brightnessctl
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
