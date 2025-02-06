{pkgs, ...}: {
  imports = [
    ./xdg-mime.nix
    ../../theming
  ];

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

    dconf-editor
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
      "org/gnome/desktop/sound" = {
        allow-volume-above-100-percent = true;
      };
    };
  };
}
