{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./dbus.nix
    ./fonts.nix
    ./pipewire.nix
  ];

  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      excludePackages = [pkgs.xterm];
    };
    gnome.gnome-keyring.enable = true;
  };

  environment.systemPackages =
    (with pkgs; [
      gnome-tweaks
      wl-clipboard
      rhythmbox
      zenity
      (writeShellScriptBin "xdg-terminal-exec" ''
        exec "${lib.getExe ghostty}" -e "$@"
      '')
    ])
    ++ lib.optionals config.services.flatpak.enable [pkgs.gnome-software];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-connections
    epiphany
    geary
    gnome-maps
    gnome-music
    totem
  ];
}
