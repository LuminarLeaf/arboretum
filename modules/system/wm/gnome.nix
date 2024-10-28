{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./dbus.nix
    ./fonts.nix
    ./gnome-keyring.nix
    ./pipewire.nix
  ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  environment.systemPackages =
    (with pkgs; [
      gnome-tweaks
      wl-clipboard
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
  ];

  # xdg.terminal-exec.settings.GNOME = [
  #   "org.gnome.Console.desktop"
  #   "org.gnome.Terminal.desktop"
  # ];

  # TODO: dconf settings
  # gsettings set org.gnome.desktop.sound allow-volume-above-100-percent ‘true’
  # Dconf Editor
}
