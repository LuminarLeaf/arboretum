{userSettings, ...}: {
  virtualisation.libvirtd = {
    allowedBridges = [
      "nm-bridge"
      "virbr0"
    ];
    enable = true;
  };

  users.users.${userSettings.username}.extraGroups = ["libvirtd"];
}
