{
  pkgs,
  config,
  userSettings,
  ...
}: {
  gtk = let
    gtk-extra-conf = {
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = true;
      gtk-menu-images = true;
      gtk-error-bell = false;
    };
  in {
    enable = true;

    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = ["mauve"];
        variant = "mocha";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "mauve";
      };
    };

    gtk3.extraConfig = gtk-extra-conf;
    gtk4.extraConfig = gtk-extra-conf;
  };

  home.file.${config.gtk.gtk2.configLocation}.force = true;

  xdg = {
    # gtk4/libadwaita
    configFile = let
      gtk4-dir = "${config.gtk.theme.package}/share/themes";
    in {
      "gtk-4.0/assets".source = "${gtk4-dir}/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${gtk4-dir}/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${gtk4-dir}/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };

    # Flatpak
    dataFile = {
      "themes/${config.gtk.theme.name}".source = config.lib.file.mkOutOfStoreSymlink "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}";
      "icons/${config.gtk.iconTheme.name}".source = config.lib.file.mkOutOfStoreSymlink "${config.gtk.iconTheme.package}/share/icons/${config.gtk.iconTheme.name}";
      "flatpak/overrides/global".text = ''
        [Context]
          filesystems=/run/media/${userSettings.username};xdg-data/themes:ro;xdg-data/icons:ro;xdg-config/gtkrc:ro;xdg-config/gtkrc-2.0:ro;xdg-config/gtk-2.0:ro;xdg-config/gtk-3.0:ro;xdg-config/gtk-4.0:ro;xdg-run/.flatpak/com.xyz.armcord.ArmCord:create;xdg-run/discord-ipc-*;xdg-config/MangoHud:ro;/nix
      '';
    };
  };
}
