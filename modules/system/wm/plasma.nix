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
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      excludePackages = [pkgs.xterm];
    };
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
    font = "Monaspace Neon";
    fontSize = "12";
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

  environment.plasma6.excludePackages = with pkgs.kdePackages; [khelpcenter];

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.login1.suspend" && subject.isInGroup("users")) {
            return polkit.Result.YES;
        }
    });
  '';
}
