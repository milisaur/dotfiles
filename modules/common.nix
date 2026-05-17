{
  config,
  pkgs,
  ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.greetd = {
    enable = false;
    settings = {
      default_session = {
        command = "Hyprland";
        user = "mili";
      };
    };
  };
  services.desktopManager.plasma6.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  console.keyMap = "de";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    epson-escpr
    gutenprint
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.sane.enable = true;
  hardware.sane.extraBackends = with pkgs; [epkowa];
  services.ipp-usb.enable = true;

  hardware.graphics.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  users.users.mili = {
    isNormalUser = true;
    description = "mili";
    extraGroups = ["networkmanager" "wheel" "video"];
    packages = with pkgs; [kdePackages.kate];
  };

  programs.firefox.enable = true;

  xdg.mime.defaultApplications = {
    "text/html" = "vivaldi";
    "x-scheme-handler/http" = "vivaldi-stable.desktop";
    "x-scheme-handler/https" = "vivaldi-stable.desktop";
    "x-scheme-handler/about" = "org.vivaldi-stable.desktop";
    "x-scheme-handler/unknown" = "org.vivaldi-stable.desktop";
  };

  fonts.packages = with pkgs; [
    powerline-fonts
    nerd-fonts.meslo-lg
    font-awesome
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-38.8.4"
  ];

  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    signal-desktop
    libreoffice-qt
    vesktop
    tor-browser
    vivaldi
    vivaldi-ffmpeg-codecs
    nextcloud-client
    v4l-utils
    guvcview
    spotify
    exfatprogs
    ntfs3g
    udiskie
    cryptsetup
  ];

  system.stateVersion = "25.11";
}
