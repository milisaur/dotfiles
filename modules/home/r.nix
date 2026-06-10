{
  pkgs,
  lib,
  ...
}: let
  rPkgs = with pkgs.rPackages; [
    languageserver
    lintr
    styler
  ];

  myR = pkgs.rWrapper.override {
    packages = rPkgs;
  };

  myRStudio = pkgs.rstudioWrapper.override {
    packages = rPkgs;
  };

  rSystemLibs = with pkgs; [];
in {
  home.packages = with pkgs; [
    myR
    myRStudio
  ];

  home.sessionVariables = {
    LD_LIBRARY_PATH = lib.makeLibraryPath rSystemLibs;
  };
}
