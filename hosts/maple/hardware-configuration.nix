# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/eb9fd95a-60c7-4a3e-a28f-d5a8c1025eed";
      fsType = "ext4";
    };

    "/media/data" = {
      device = "/dev/disk/by-uuid/a2367809-5415-48b9-a590-8e183f7aa166";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/5222-F226";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };

    "/media/ext_wd" = {
      device = "/dev/disk/by-uuid/b6159c83-8d35-4e50-81cd-422028ef1fa6";
      fsType = "ext4";
      options = ["defaults" "nofail" "noauto" "user"];
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/d045b87a-3358-4abf-9dad-c23eb6b20895";}
  ];

  boot.resumeDevice = "/dev/disk/by-uuid/d045b87a-3358-4abf-9dad-c23eb6b20895";

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno2.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
