{pkgs, ...}: {
  programs.zathura = {
    enable = true;

    options = {
      selection-clipboard = "clipboard";
      recolor = true;
      recolor-keephue = true;
      statusbar-home-tilde = true;
    };
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = ["org.pwmt.zathura.desktop"];
  };
}
