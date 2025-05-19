{
  lib,
  config,
  ...
}: let
  cfg = config.custom.hardware.nvidia;
  nvidiaDriverChannel = config.boot.kernelPackages.nvidiaPackages.beta; # stable, latest, beta, etc.
in {
  options = {
    custom.hardware.nvidia.disableNvidia = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Disable NVIDIA graphics card";
    };
    custom.hardware.nvidia.enablePrime = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA Prime";
    };
  };

  config = {
    # Nvidia Disabled
    boot = lib.mkIf cfg.disableNvidia {
      blacklistedKernelModules = [
        "nouveau"
        "nvidia"
        "nvidia_drm"
        "nvidia_uvm"
        "nvidia_modeset"
      ];
      extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';
    };
    services.udev.extraRules = lib.mkIf cfg.disableNvidia ''
      # Remove NVIDIA USB xHCI Host Controller devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA USB Type-C UCSI devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA Audio devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
      # Remove NVIDIA VGA/3D controller devices
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
    '';

    # Nvidia Enabled (Default)
    services.xserver.videoDrivers = lib.mkIf (!cfg.disableNvidia) ["nvidia"];
    hardware = lib.mkIf (!cfg.disableNvidia) {
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = true;
        open = true;
        nvidiaSettings = true;
        dynamicBoost.enable = true;

        package = nvidiaDriverChannel;

        # Enable NVIDIA Prime
        prime = lib.mkIf cfg.enablePrime {
          offload.enable = true;
          offload.enableOffloadCmd = true;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };
  };
}
