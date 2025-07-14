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
      {package = pkgs.gnomeExtensions.appindicator;}
      {package = pkgs.gnomeExtensions.blur-my-shell;}
      {package = pkgs.gnomeExtensions.clipboard-indicator;}
      {package = pkgs.gnomeExtensions.dash-to-dock;}
      {package = pkgs.gnomeExtensions.fullscreen-to-empty-workspace-2;}
      {package = pkgs.gnomeExtensions.pip-on-top;}
      {package = pkgs.gnomeExtensions.resolution-and-refresh-rate-in-quick-settings;}
      {package = pkgs.gnomeExtensions.grand-theft-focus;}
    ];
  };

  home.packages = with pkgs; [
    gnome-tweaks
    celluloid
    exaile
    deadbeef-with-plugins
    # monitorets
    # resources

    dconf-editor
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        accent-color = "purple";
        color-scheme = "prefer-dark";
        show-battery-percentage = true;
        font-name = "sans-serif 11";
        document-font-name = "serif 11";
        monospace-font-name = "monospace 11";
      };
      "org/gnome/mutter/wayland/keybindings" = {restore-shortcuts = "@as []";};
      "org/gnome/desktop/input-sources" = {xkb-options = ["lv3:rwin_switch"];};
      "org/gnome/desktop/peripherals/mouse" = {accel-profile = "flat";};
      "org/gnome/desktop/session" = {idle-delay = "uint32 600";};
      "org/gnome/desktop/sound" = {allow-volume-above-100-percent = true;};
      "org/gnome/desktop/wm/keybindings" = {
        switch-applications = ["<Super>Tab"];
        switch-applications-backward = ["<Shift><Super>Tab"];
        siwtch-windows = ["<Alt>Tab"];
        switch-windows-backward = ["<Shift><Alt>Tab"];
      };
      "org/gnome/desktop/wm/preferences" = {
        audible-bell = false;
        resize-with-right-button = true;
        visual-bell = false;
      };
      "org/gnome/settings-daemon/plugins/power" = {sleep-inactive-ac-type = "nothing";};
      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"];
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
        command = "ghostty";
        name = "Terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "F9";
        command = "obs-do toggle-record";
        name = "OBS Toggle Record";
      };
      "org/gnome/shell" = {favorite-apps = ["org.gnome.Nautilus.desktop" "firefox.desktop" "com.mitchellh.ghostty.desktop" "vesktop.desktop" "spotify.desktop"];};
      "org/gnome/shell/app-switcher" = {current-workspace-only = true;};
      "org/gnome/shell/keybindings" = {
        focus-active-notification = "@as []";
        toggle-message-tray = ["<Super>n"];
      };
      "org/gnome/shell/extensions/blur-my-shell/applications" = {
        blur = false;
        # dynamic-opacity = false;
        # whitelist = ["com.mitchellh.ghostty" "kitty"];
      };
      "org/gnome/shell/extensions/clipboard-indicator" = {
        cache-size = 10;
        enable-keybindings = false;
        paste-button = false;
      };
      "org/gnome/shell/extensions/dash-to-dock" = {
        dash-max-icon-size = 36;
        intellihide-mode = "ALL_WINDOWS";
        show-mounts = false;
        show-show-apps-button = true;
        show-trash = false;
      };
      "org/gnome/shell/extensions/fullscreen-to-empty-workspace" = {move-window-when-maximized = false;};
      "org/gnome/shell/extensions/pip-on-top" = {stick = true;};
    };
  };
}
