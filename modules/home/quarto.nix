{pkgs, ...}: {
  home.packages = with pkgs; [
    quarto
    pandoc
    typst
  ];
}
