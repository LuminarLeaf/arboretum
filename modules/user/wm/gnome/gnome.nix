{pkgs, ...}: {
  programs = {
    gnome-shell = {
      enable = true;
      theme = {
        name = "Marble-purple-dark";
        package = pkgs.marble-shell-theme.override {additionalInstallationTweaks = ["--filled"];};
      };
      extensions = [
        {package = pkgs.gnomeExtensions.clipboard-indicator;}
        {package = pkgs.gnomeExtensions.dash-to-dock;}
        {package = pkgs.gnomeExtensions.appindicator;}
        {package = pkgs.gnomeExtensions.blur-my-shell;}
        {package = pkgs.gnomeExtensions.window-is-ready-remover;}
        {package = pkgs.gnomeExtensions.pip-on-top;}
        {package = pkgs.gnomeExtensions.rounded-window-corners-reborn;}
      ];
    };
  };
  home.packages = with pkgs; [
    gnome-tweaks
    qogir-icon-theme
    whitesur-icon-theme
    # rose-pine-gtk-theme
    # omni-gtk-theme
    # kanagawa-gtk-theme
    # colloid-gtk-theme
    # fluent-gtk-theme
    # nightfox-gtk-theme
    # whitesur-gtk-theme
    # tokyonight-gtk-theme
    # graphite-gtk-theme

    # TODO: find which gsettings to have by default
    dconf-editor
  ];

  xdg.mimeApps.defaultApplications = {
    "image/png" = "org.gnome.Loupe.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/gif" = "org.gnome.Loupe.desktop";
    "image/bmp" = "org.gnome.Loupe.desktop";
  };
}
