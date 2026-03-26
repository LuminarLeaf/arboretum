{
  lib,
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
    gtk4 = {
      inherit (config.gtk) theme;
      extraConfig = gtk-extra-conf;
    };
  };

  home.file.${config.gtk.gtk2.configLocation}.force = lib.mkForce true;

  xdg = {
    # gtk4/libadwaita
    configFile = let
      gtk4-dir = "${config.gtk.theme.package}/share/themes";
    in {
      "gtk-4.0/assets".source = "${gtk4-dir}/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${gtk4-dir}/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    };
  };
}
