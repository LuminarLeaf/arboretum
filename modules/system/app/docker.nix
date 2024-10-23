{
  lib,
  config,
  pkgs,
  userSettings,
  storageDriver ? null,
  ...
}:
assert lib.asserts.assertOneOf "storageDriver" storageDriver [
  null
  "aufs"
  "btrfs"
  "devicemapper"
  "overlay"
  "overlay2"
  "zfs"
]; {
  options = {
    custom.docker.powerSave = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable power saving features for Docker.";
    };
  };

  config = {
    users.users.${userSettings.username}.extraGroups = ["docker"];

    virtualisation.docker = lib.mkIf (!config.custom.docker.powerSave) {
      enable = true;
      storageDriver = storageDriver;
    };

    environment.systemPackages = lib.mkIf (!config.custom.docker.powerSave) [
      pkgs.docker
      pkgs.docker-compose
    ];

    # Nvidia Container Toolkit based on wether Nvidia gpu is enabled or not
    hardware.nvidia-container-toolkit.enable =
      config.hardware.nvidia.modesetting.enable
      && !config.custom.docker.powerSave;
  };
}
