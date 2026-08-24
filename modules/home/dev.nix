{
  pkgs,
  mars-mips,
  asm-simulator,
  hades,
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
    golangci-lint

    python3
    pyright

    jdk21
    asm-simulator
    hades
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
