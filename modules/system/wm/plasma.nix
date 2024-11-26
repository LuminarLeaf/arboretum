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
    displayManager.sddm = {
      enable = true;
      catppuccin = {
        enable = true;
        font = "JetBrainsMono Nerd Font";
        fontSize = "12";
      };
      settings.General.InputMethod = "";
    };
    desktopManager.plasma6.enable = true;
  };

  environment.systemPackages =
    (with pkgs; [
      wl-clipboard
      kdePackages.filelight
      kdePackages.kate
      kdePackages.kcalc
      kdePackages.kcharselect
    ])
    ++ (
      if (config.services.flatpak.enable)
      then [pkgs.kdePackages.discover]
      else []
    );

  xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [khelpcenter];
}
