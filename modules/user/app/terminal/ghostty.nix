{...}: {
  programs.ghostty = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      background-blur-radius = 1;
      background-opacity = 0.9;

      confirm-close-surface = false;

      font-size = 12;
      font-family = "MonaspiceNe Nerd Font";
      font-family-italic = "MonaspiceRn Nerd Font";
      font-family-bold-italic = "MonaspiceRn Nerd Font";

      gtk-tabs-location = "bottom";
      gtk-titlebar = false;

      window-decoration = "client"; # issues in plasma
      window-padding-color = "extend";
    };
  };
  catppuccin.ghostty.enable = true;
}
