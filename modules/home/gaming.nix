{pkgs, ...}: {
  home.packages = with pkgs; [
    prismlauncher
    mangohud
    goverlay
  ];

  programs.vesktop = {
    enable = true;
  };
}
