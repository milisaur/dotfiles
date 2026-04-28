{
  pkgs,
  lib,
  ...
}: let
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

  rSystemLibs = with pkgs; [
    libuv
    curl
    openssl
    zlib
    libxml2
    fontconfig
    freetype
    harfbuzz
    fribidi

    libpng
    libtiff
    libjpeg
    libwebp
    bzip2
  ];
in {
  home.packages = with pkgs; [
    myR
    myRStudio

    pkg-config
    cmake
    gnumake
    gcc

    libuv.dev
    curl.dev
    openssl.dev
    zlib.dev
    libxml2.dev
    fontconfig.dev
    freetype.dev
    harfbuzz.dev
    fribidi.dev

    libpng.dev
    libtiff.dev
    libjpeg.dev
    libwebp
    bzip2.dev
  ];

  home.sessionVariables = {
    PKG_CONFIG_PATH = lib.concatStringsSep ":" [
      "${pkgs.libuv.dev}/lib/pkgconfig"
      "${pkgs.curl.dev}/lib/pkgconfig"
      "${pkgs.openssl.dev}/lib/pkgconfig"
      "${pkgs.zlib.dev}/lib/pkgconfig"
      "${pkgs.libxml2.dev}/lib/pkgconfig"
      "${pkgs.fontconfig.dev}/lib/pkgconfig"
      "${pkgs.freetype.dev}/lib/pkgconfig"
      "${pkgs.harfbuzz.dev}/lib/pkgconfig"
      "${pkgs.fribidi.dev}/lib/pkgconfig"
      "${pkgs.libpng.dev}/lib/pkgconfig"
      "${pkgs.libtiff.dev}/lib/pkgconfig"
      "${pkgs.libjpeg.dev}/lib/pkgconfig"
      "${pkgs.libwebp}/lib/pkgconfig"
      "${pkgs.bzip2.dev}/lib/pkgconfig"
    ];

    LD_LIBRARY_PATH = lib.makeLibraryPath rSystemLibs;
  };
}
