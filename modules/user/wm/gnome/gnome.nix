{
  pkgs,
  config,
  userSettings,
  ...
}: {
  imports = [
    ./xdg-mime.nix
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

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.qogir-icon-theme.override {
      colorVariants = ["dark"];
      themeVariants = ["default"];
    };
    name = "Qogir-dark";
    size = 32;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Reversal-purple-dark";
      package = pkgs.reversal-icon-theme.override {colorVariants = ["-purple"];};
    };
    theme = {
      name = "Tokyonight-Purple-Dark";
      package = pkgs.tokyonight-gtk-theme.override {
        colorVariants = ["dark"];
        sizeVariants = ["standard"];
        themeVariants = ["purple"];
      };
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

  xdg = {
    configFile = {
      "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
      "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
      "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
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
