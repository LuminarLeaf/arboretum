{
  lib,
  pkgs,
  config,
  inputs,
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
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
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
      theme = null;
      extraConfig = gtk-extra-conf;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "accent-color" = "purple";
    };
  };

  home.file.${config.gtk.gtk2.configLocation}.force = lib.mkForce true;

  xdg = {
    # gtk4/libadwaita
    configFile = let
      inherit (config.catppuccin) flavor accent;
      get-adw-css = gtk: "${inputs.adw-catppuccin}/themes/${flavor}/catppuccin-${flavor}-${accent}${
        if gtk == 3
        then "-gtk3"
        else ""
      }.css";
    in {
      "gtk-4.0/gtk.css".source = get-adw-css 4;
      "gtk-3.0/gtk.css".source = get-adw-css 3;
    };
  };
}
