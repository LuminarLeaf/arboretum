{
  pkgs,
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
    };
    gnome.gnome-keyring.enable = true;
  };

  environment.systemPackages =
    (with pkgs; [
      gnome-tweaks
      wl-clipboard
      rhythmbox
      blackbox-terminal
      zenity
      (writeShellScriptBin "xdg-terminal-exec" ''
        exec "${lib.getExe blackbox-terminal}" -c "$@"
      '')
    ])
    ++ (
      if (config.services.flatpak.enable)
      then [pkgs.gnome-software]
      else []
    );

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
