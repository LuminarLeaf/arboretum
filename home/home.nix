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
    ../modules/user/app/terminal/kitty.nix
    ../modules/user/app/git/git.nix
    ../modules/user/app/spicetify.nix
    ../modules/user/app/mangohud.nix

    ../modules/user/shell/zsh.nix
    ../modules/user/shell/neovim/nvim.nix
    ../modules/user/shell/cli-tools.nix

    ../modules/user/wm/plasma/plasma.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  home.packages = with pkgs; [
    obsidian
    vscode
    localsend
    vesktop
    mpv
    firefox
    motrix
    prismlauncher
  ];

  programs.obs-studio.enable = true;
  programs.obs-studio.catppuccin.enable = true;

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    publicShare = null;
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  news.display = "silent";
}
