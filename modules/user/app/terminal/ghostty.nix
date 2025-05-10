{...}: {
  programs.ghostty = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      background-blur-radius = 1;
      background-opacity = 0.9;
      unfocused-split-opacity = 1;

      confirm-close-surface = false;

      font-size = 12;
      font-family = "MonaspiceNe Nerd Font";
      font-feature = "+calt, +liga, +ss01, +ss02, +ss03, +ss04, +ss05, +ss06, +ss07, +ss08, +ss09";

      gtk-tabs-location = "bottom";
      gtk-titlebar = false;
      gtk-single-instance = true;

      window-decoration = "client"; # issues in plasma
      window-padding-balance = true;
    };
  };
  catppuccin.ghostty.enable = true;
}
