{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty
    git
    git-crypt
    gnupg
    nano
    zsh

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
