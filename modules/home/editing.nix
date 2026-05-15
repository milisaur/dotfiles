{pkgs, ...}: {
  home.packages = with pkgs; [
    inkscape
    digiKam
    darktable
    rawtherapee
  ];
}
