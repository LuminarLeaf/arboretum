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

      font-size = 13;
      font-family = "monospace";

      # gtk-tabs-location = "bottom";
      gtk-titlebar = false;

      window-decoration = "client"; # issues in plasma
      window-padding-balance = true;
    };
  };
  catppuccin.ghostty.enable = true;
}
