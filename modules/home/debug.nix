{pkgs, ...}: {
  home.packages = with pkgs; [
    lsof
    psmisc
    pciutils
  ];
}
