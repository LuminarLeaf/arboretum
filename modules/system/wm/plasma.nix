{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./dbus.nix
    ./fonts.nix
    ./pipewire.nix
  ];

  services = {
    gvfs.enable = true;
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      settings.Theme = {
        CursorTheme = "Bibata-Modern-Ice";
        CursorSize = 24;
      };
    };
    desktopManager.plasma6.enable = true;
  };

  catppuccin.sddm = {
    enable = true;
    font = "monospace";
    fontSize = "12";
  };

  programs.ssh.enableAskPassword = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  environment.systemPackages =
    (with pkgs; [
      bibata-cursors
      wl-clipboard
      kdePackages.filelight
      kdePackages.kate
      kdePackages.kcalc
      kdePackages.kcharselect
      kdePackages.kdialog
    ])
    ++ lib.optionals config.services.flatpak.enable [pkgs.kdePackages.discover];

  xdg.portal.extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [khelpcenter qrca];

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.login1.suspend" && subject.isInGroup("users")) {
            return polkit.Result.YES;
        }
    });
  '';
}
