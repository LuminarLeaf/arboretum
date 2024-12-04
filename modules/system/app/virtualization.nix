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
        ++ (
          if config.custom.quickemu
          then [pkgs.quickemu]
          else []
        );
    })
    (lib.mkIf config.custom.virt-manager {programs.virt-manager.enable = true;})
    (lib.mkIf config.custom.waydroid {
      virtualisation.waydroid.enable = true;
      # environment.systemPackages = [pkgs.androidenv.androidPkgs.platform-tools];
      programs.adb.enable = true;
      users.users.${userSettings.username} = {extraGroups = ["adbusers"];};
    })
  ];
}
