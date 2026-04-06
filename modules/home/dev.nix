{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    git
    git-crypt
    gnupg
    nano
    zsh
    rofi

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
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
