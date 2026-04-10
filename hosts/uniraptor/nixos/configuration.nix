{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../../modules/common.nix
    ../../../modules/sddm.nix
    ../../../modules/sddm-x11.nix
    ../../../modules/plasma.nix
  ];

  networking.hostName = "uniraptor";

  environment.systemPackages = with pkgs; [
    git
    neovim
  ];

  system.stateVersion = "25.11";
}
