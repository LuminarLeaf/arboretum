{
  pkgs,
  userSettings,
  ...
}: {
  hardware.openrazer = {
    enable = true;
    users = [userSettings.username];
  };
  environment.systemPackages = [pkgs.polychromatic];
}
