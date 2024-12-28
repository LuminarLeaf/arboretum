{
  pkgs,
  config,
  userSettings,
  ...
}: {
  imports = [
    ./xdg-mime.nix
  ];

  home = {
    pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.qogir-icon-theme.override {
        colorVariants = ["dark"];
        themeVariants = ["default"];
      };
      name = "Qogir-dark";
      size = 24;
    };

    packages = with pkgs; [
      deadbeef-with-plugins
      haruna
    ];

    sessionVariables.SSH_ASKPASS_REQUIRE = "prefer";

    file.${config.gtk.gtk2.configLocation}.force = true;
  };

  # TODO: plasma-manager for plasma colors, otherwise this looks bad
  qt = {
    enable = true;
    style.name = "kvantum";
    platformTheme.name = "kvantum";
  };
  catppuccin.kvantum = {
    enable = true;
    apply = true;
  };

  gtk = {
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
        accent = "lavender";
      };
    };
  };

  xdg = {
    configFile = let
      gtk4-dir = "${config.gtk.theme.package}/share/themes";
    in {
      "gtk-4.0/assets".source = "${gtk4-dir}/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${gtk4-dir}/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${gtk4-dir}/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
    };

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
