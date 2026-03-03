{pkgs, ...}: {
  # daemon
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
  };
  # gui
  environment.systemPackages = [pkgs.mullvad-vpn];
}
