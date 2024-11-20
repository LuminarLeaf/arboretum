{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./dbus.nix
    ./fonts.nix
    ./pipewire.nix
  ];

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    # displayManager.sddm.enable = true;
    # displayManager.sddm.catppuccin.enable = true;
    displayManager.sddm = {
      enable = true;
      catppuccin.enable = true;
      settings.General.InputMethod = "";
    };
    desktopManager.plasma6.enable = true;
  };

  environment.systemPackages =
    (with pkgs; [
      wl-clipboard
      kdePackages.kate
    ])
    ++ (
      if (config.services.flatpak.enable)
      then [pkgs.kdePackages.discover]
      else []
    );

  xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [khelpcenter];
}
