{pkgs, ...}: {
  dconf = {
    enable = true;

    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Papirus-Dark";
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    # GTK4 verwendet die dunkle Farbpräferenz.
    # Erzwinge kein GTK4-Theme für libadwaita.
    gtk4.theme = null;
  };

  qt = {
    enable = true;

    platformTheme.name = "gtk3";

    style = {
      name = "adwaita-dark";
      package = [
        pkgs.adwaita-qt
        pkgs.adwaita-qt6
      ];
    };
  };
}
