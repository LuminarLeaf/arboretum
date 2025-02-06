{pkgs, ...}: {
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
}
