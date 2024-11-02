{pkgs, ...}: let
  gtk-theme = pkgs.tokyonight-gtk-theme.override {
    colorVariants = ["dark"];
    sizeVariants = ["standard"];
    themeVariants = ["purple"];
  };
  gtk-theme-name = "Tokyonight-Purple-Dark";
  gtk4dir = "${gtk-theme}/share/themes/${gtk-theme-name}/gtk-4.0";
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
    cursorTheme.name = "Qogir-dark";
    iconTheme.name = "Reversal-purple-dark";
    theme.name = gtk-theme-name;
  };

  home.packages = with pkgs; [
    gnome-tweaks
    exaile
    deadbeef-with-plugins
    # TODO: somehow patch reversal's foder icons into whitesur along with qogir's cursors in a curstom derivation
    # (qogir-icon-theme.override {
    #   colorVariants = ["dark"];
    #   themeVariants = ["default"];
    # })
    (reversal-icon-theme.override {colorVariants = ["-purple"];})
    gtk-theme

    # TODO: find which gsettings to have by default
    dconf-editor
  ];

  home.sessionVariables = {
    GTK_THEME = gtk-theme-name;
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${gtk4dir}/assets";
    "gtk-4.0/gtk.css".source = "${gtk4dir}/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${gtk4dir}/gtk-dark.css";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = "org.gnome.TextEditor.desktop";

    "image/png" = "org.gnome.Loupe.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/gif" = "org.gnome.Loupe.desktop";
    "image/bmp" = "org.gnome.Loupe.desktop";
  };
}
