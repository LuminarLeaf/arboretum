{
  pkgs,
  config,
  userSettings,
  ...
}: let
  gtk-theme-package = pkgs.tokyonight-gtk-theme.override {
    colorVariants = ["dark"];
    sizeVariants = ["standard"];
    themeVariants = ["purple"];
  };
in {
  programs.gnome-shell = {
    enable = true;
    theme = {
      name = "Marble-purple-dark";
      package = pkgs.marble-shell-theme.override {
        additionalInstallationTweaks = ["--filled"];
        colors = ["purple"];
      };
    };
    extensions = [
      {package = pkgs.gnomeExtensions.clipboard-indicator;}
      {package = pkgs.gnomeExtensions.dash-to-dock;}
      {package = pkgs.gnomeExtensions.appindicator;}
      {package = pkgs.gnomeExtensions.blur-my-shell;}
      {package = pkgs.gnomeExtensions.window-is-ready-remover;}
      {package = pkgs.gnomeExtensions.pip-on-top;}
    ];
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.qogir-icon-theme.override {
      colorVariants = ["dark"];
      themeVariants = ["default"];
    };
    name = "Qogir-dark";
  };

  gtk = {
    cursorTheme = {
      name = "Qogir-dark";
      size = 24;
    };
    iconTheme.name = "Reversal-purple-dark";
    theme = {
      name = "Tokyonight-Purple-Dark";
      package = gtk-theme-package;
    };
  };

  home.packages = with pkgs; [
    gnome-tweaks
    celluloid
    exaile
    deadbeef-with-plugins
    # TODO: somehow patch reversal's foder icons into whitesur along with qogir's cursors in a curstom derivation
    # (qogir-icon-theme.override {
    #   colorVariants = ["dark"];
    #   themeVariants = ["default"];
    # })
    (reversal-icon-theme.override {colorVariants = ["-purple"];})

    # TODO: find which gsettings to have by default
    dconf-editor
  ];

  # home.sessionVariables = {
  #   GTK_THEME = gtk-theme-name;
  # };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
  xdg.dataFile = {
    "themes/${config.gtk.theme.name}".source = config.lib.file.mkOutOfStoreSymlink "${gtk-theme-package}/share/themes/${config.gtk.theme.name}";
    "icons/${config.gtk.iconTheme.name}".source = config.lib.file.mkOutOfStoreSymlink "${pkgs.reversal-icon-theme.override {colorVariants = ["-purple"];}}/share/icons/${config.gtk.iconTheme.name}";
    "flatpak/overrides/global".text = ''
      [Context]
        filesystems=/run/media/${userSettings.username};xdg-data/themes:ro;xdg-data/icons:ro;xdg-config/gtkrc:ro;xdg-config/gtkrc-2.0:ro;xdg-config/gtk-2.0:ro;xdg-config/gtk-3.0:ro;xdg-config/gtk-4.0:ro;xdg-run/.flatpak/com.xyz.armcord.ArmCord:create;xdg-run/discord-ipc-*;xdg-config/MangoHud:ro;/nix
    '';
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "org.gnome.TextEditor.desktop";

    "image/png" = "org.gnome.Loupe.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/gif" = "org.gnome.Loupe.desktop";
    "image/bmp" = "org.gnome.Loupe.desktop";
    "image/webp" = "org.gnome.Loupe.desktop";

    # "video/mp4" = "";
    # "video/mpeg" = "";
    # "video/x-matroska" = "";
    # "video/webm" = "";
  };
}
