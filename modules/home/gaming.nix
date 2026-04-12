{pkgs, ...}: {
  home.packages = with pkgs; [
    prismlauncher
    mangohud
    goverlay
    mumble
  ];
}
