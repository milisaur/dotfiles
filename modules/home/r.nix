{pkgs, ...}: let
  rPkgs = with pkgs.rPackages; [
    tidyverse
    languageserver
    data_table
    jsonlite
    devtools
    psych
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
