{
  pkgs,
  lib,
  config,
  userSettings,
  ...
}: {
  options = let
    mkCustomOption = desc:
      lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable ${desc}";
      };
  in {
    custom.qemu = mkCustomOption "QEMU";
    custom.quickemu = mkCustomOption "QuickEMU";
    custom.virt-manager = mkCustomOption "Virtual Machine Manager";
    custom.waydroid = mkCustomOption "WayDroid";
  };

  config = lib.mkMerge [
    (lib.mkIf config.custom.qemu {
      virtualisation.libvirtd.qemu.runAsRoot = false;
      environment.systemPackages =
        [pkgs.qemu]
        ++ lib.optionals config.custom.quickemu [pkgs.quickemu];
    })

    (lib.mkIf config.custom.virt-manager {programs.virt-manager.enable = true;})

    (lib.mkIf config.custom.waydroid {virtualisation.waydroid.enable = true;})

    {
      environment.systemPackages = [pkgs.android-tools];
      users.users.${userSettings.username} = {extraGroups = ["adbusers"];};
    }
  ];
}
