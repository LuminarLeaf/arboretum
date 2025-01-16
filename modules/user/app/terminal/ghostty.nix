{...}: {
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";

      background-blur-radius = 1;
      background-opacity = 0.8;

      font-size = 12;
      font-family = "MonaspiceNe Nerd Font";
      font-family-italic = "MonaspiceRn Nerd Font";
      font-family-bold-italic = "MonaspiceRn Nerd Font";

      gtk-tabs-location = "bottom";
      gtk-titlebar = false;
      window-padding-color = "extend";
    };
  };
}
