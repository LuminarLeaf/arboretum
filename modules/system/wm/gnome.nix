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
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      excludePackages = [pkgs.xterm];
    };
    gnome = {
      gnome-keyring.enable = true;
      sushi.enable = true;
    };
  };

  environment.systemPackages =
    (with pkgs; [
      ffmpegthumbnailer
      gnome-tweaks
      gradia
      nautilus-python
      wl-clipboard
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
