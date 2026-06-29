{
  config,
  pkgs,
  lib,
  ...
}: {
  # Laptop battery optimization.
  # Do not enable power-profiles-daemon together with TLP.
  services.power-profiles-daemon.enable = lib.mkForce false;

  services.udev.extraRules = ''
    # Force TLP to re-apply power profile when AC state changes.
    ACTION=="change", SUBSYSTEM=="power_supply", RUN+="${pkgs.tlp}/bin/tlp auto"
  '';

  services.tlp = {
    enable = true;

    settings = {
      # CPU
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # Intel / platform power profile
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Runtime device power management
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      # Wi-Fi / audio / USB
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
      SOUND_POWER_SAVE_CONTROLLER = "Y";

      USB_AUTOSUSPEND = 1;

      # Battery charging thresholds.
      # Only works if your laptop firmware supports it.
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  # Intel Iris Xe power saving.
  boot.kernelParams = [
    "i915.enable_psr=1"
  ];

  # Useful inspection tools.
  environment.systemPackages = with pkgs; [
    powertop
    acpi
    upower
    lm_sensors
  ];

  # Optional, but useful on Intel laptops.
  services.thermald.enable = true;
}
