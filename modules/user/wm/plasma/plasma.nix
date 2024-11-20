{
  pkgs,
  config,
  userSettings,
  ...
}: {
  imports = [
    ./xdg-mime.nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.qogir-icon-theme.override {
      colorVariants = ["dark"];
      themeVariants = ["default"];
    };
    name = "Qogir-dark";
    size = 24;
  };

  # TODO: plasma-manager for plasma colors, otherwise this looks bad

  # qt = {
  #   enable = true;
  #   style = {
  #     catppuccin.enable = true;
  #     catppuccin.apply = true;
  #     name = "kvantum";
  #   };
  #   platformTheme.name = "kvantum";
  # };

  home.packages = with pkgs; [
    deadbeef-with-plugins
    haruna
  ];

  gtk.enable = true;
}
