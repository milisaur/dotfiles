{
  pkgs,
  mars-mips,
  ...
}: {
  home.packages = with pkgs; [
    kitty
    git
    git-crypt
    gnupg
    nano
    zsh
    wev

    yazi
    rofi
    papirus-icon-theme
    mako
    networkmanagerapplet

    gnome-keyring
    seahorse

    pavucontrol
    libnotify

    curl
    wget
    unzip

    file
    jq
    zoxide
    ffmpeg
    poppler
    imagemagick
    ueberzugpp
    mpv
    imv

    ripgrep
    fd
    fzf
    bat
    btop
    lazygit

    texliveFull
    texstudio

    go
    gopls
    gotools

    python3
    pyright

    jdk21
    mars-mips

    direnv
    nix-direnv
    alejandra

    playerctl
    brightnessctl

    anki
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
