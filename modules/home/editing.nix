{pkgs, ...}: {
  home.packages = with pkgs; [
    inkscape
    gimp
    digikam
    darktable
    rawtherapee
  ];
}
