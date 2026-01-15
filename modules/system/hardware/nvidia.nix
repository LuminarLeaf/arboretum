{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.custom.hardware.nvidia;
  nvidiaDriverChannel = config.boot.kernelPackages.nvidiaPackages.beta; # stable, latest, beta, etc.
in {
  # TODO: Fix this BS in the refactor;
  options = {
    custom.hardware.nvidia.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable nvidia support";
    };
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
    custom.hardware.nvidia.pci_passthrough = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable pci pci_passthrough for nvidia cards";
    };
  };

  #TODO: Add assertions

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.xserver.videoDrivers = ["modesetting" "nvidia"];
      # environment.systemPackages = [pkgs.lact];
      # systemd.services.lactd = {
      #   description = "GPU Control Daemon";
      #   wantedBy = ["multi-user.target"];
      #   after = ["multi-user.target"];
      #   serviceConfig = {
      #     ExecStart = "${lib.getExe' pkgs.lact "lact"} daemon";
      #     Restart = "on-failure";
      #     Nice = "-10";
      #   };
      # };
      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = true;
        open = true;
        nvidiaSettings = false;
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
    })

    (lib.mkIf cfg.disableNvidia {
      boot = {
        blacklistedKernelModules = [
          "nouveau"
          "nvidia"
          "nvidiafb"
          "nvidia_drm"
          "nvidia_uvm"
          "nvidia_modeset"
        ];
      };
      services.udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
    })

    (lib.mkIf cfg.pci_passthrough {
      boot = {
        initrd.kernelModules = [
          "vfio"
          "vfio_pci"
          "vfio_iommu_type1"
        ];
        blacklistedKernelModules = [
          "nouveau"
          "nvidia"
          "nvidiafb"
          "nvidia_drm"
          "nvidia_uvm"
          "nvidia_modeset"
        ];
        kernelParams = [
          "intel_iommu=on"
          "iommu=pt"
          "vfio-pci.ids=10de:25a2,10de:2291"
        ];
        extraModprobeConfig = "options vfio-pci ids=10de:25a2,10de:2291";
      };
    })
  ];
}
