{
  config,
  pkgs,
  lib,
  ...
}: {
  # Intel iGPU + NVIDIA dGPU hybrid setup.
  # Intel renders the desktop; NVIDIA is used only when explicitly requested.

  services.xserver.videoDrivers = ["nvidia"];
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidiafb"
  ];

  boot.kernelParams = [
    "nouveau.modeset=0"
  ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;

    # Important for laptops: allows the NVIDIA GPU to power down when unused.
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # Your PCI IDs:
      # Intel Iris Xe: 00:02.0
      # NVIDIA RTX 4060: 01:00.0
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  environment.systemPackages = with pkgs; [
    mesa-demos
    vulkan-tools
    nvtopPackages.nvidia

    (writeShellScriptBin "nvidia-offload" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only

      exec "$@"
    '')
  ];
}
