{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs = {
    gnome-shell = {
      enable = true;
      # theme = {
      #   name = "Marble-purple-dark";
      #   package = pkgs-unstable.marble-shell-theme.override {
      #     colors = ["all"];
      #     additionalInstallationTweaks = ["--filled"];
      #   };
      # };
      extensions = [
        {package = pkgs.gnomeExtensions.clipboard-indicator;}
        {package = pkgs.gnomeExtensions.dash-to-dock;}
        {package = pkgs.gnomeExtensions.appindicator;}
        {package = pkgs.gnomeExtensions.blur-my-shell;}
        {package = pkgs-unstable.gnomeExtensions.window-is-ready-remover;}
        {package = pkgs-unstable.gnomeExtensions.pip-on-top;}
      ];
    };
  };
  home.packages = with pkgs; [
    gnome.gnome-tweaks
    qogir-icon-theme
    whitesur-icon-theme

    # TODO: find which gsettings to have by default
    gnome.dconf-editor
  ];

  xdg.mimeApps.defaultApplications = {
    "image/png" = "org.gnome.Loupe.desktop";
    "image/jpeg" = "org.gnome.Loupe.desktop";
    "image/gif" = "org.gnome.Loupe.desktop";
    "image/bmp" = "org.gnome.Loupe.desktop";
  };
}
