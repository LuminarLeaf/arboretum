{
  pkgs,
  userSettings,
  ...
}: {
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;

  home.stateVersion = "24.05";

  imports = [
    ../modules/user/app/browser/firefox.nix
    ../modules/user/app/terminal/alacritty.nix
    ../modules/user/app/terminal/ghostty.nix
    ../modules/user/app/terminal/kitty.nix
    ../modules/user/app/git/git.nix
    ../modules/user/app/mpv.nix
    ../modules/user/app/spicetify.nix
    ../modules/user/app/gaming.nix
    ../modules/user/app/qbittorrent.nix

    ../modules/user/shell/shell.nix
    ../modules/user/shell/nvim.nix
    ../modules/user/shell/cli-tools.nix

    # ../modules/user/wm/plasma/plasma.nix
    ../modules/user/wm/gnome/gnome.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    foliate
    gimp3-with-plugins
    inkscape
    libreoffice-fresh
    obs-do
    obsidian
    varia
    vesktop
    vscode-fhs
    # apostrophe
    # runemaster
  ];

  # home.sessionVariables.NIXOS_OZONE_WL = 1;

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {cudaSupport = true;};
  };
  catppuccin.obs.enable = true;

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      publicShare = null;
    };
    mime.enable = true;
    mimeApps.enable = true;
  };

  news.display = "silent";
}
