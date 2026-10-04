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

    gh
    bind
    usbutils
    parted

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

    jdk25
    asm-simulator
    hades
    mars-mips

    direnv
    nix-direnv
    alejandra

    playerctl
    brightnessctl

    anki

    steam-run

    maven
    tree
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
