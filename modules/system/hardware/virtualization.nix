{userSettings, ...}: {
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  users.users.${userSettings.username}.extraGroups = ["libvirtd"];
}
