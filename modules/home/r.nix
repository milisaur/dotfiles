{pkgs, ...}: let
  rPkgs = with pkgs.rPackages; [
    languageserver
    renv
  ];

  myR = pkgs.rWrapper.override {
    packages = rPkgs;
  };

  myRStudio = pkgs.rstudioWrapper.override {
    packages = rPkgs;
  };
in {
  home.packages = [
    myR
    myRStudio
  ];
}
