{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    android-tools
  ];

  programs.adb.enable = true;

  users.users.mili.extraGroups = [
    "adbusers"
    "kvm"
  ];
}
