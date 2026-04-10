{
  config,
  pkgs,
  ...
}: {
  services.displayManager.sddm.wayland.enable = false;

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "xcb";
  };
}
