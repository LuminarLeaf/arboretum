{pkgs, ...}: {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  gtk.cursorTheme = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      "cursor-theme" = "Bibata-Modern-Ice";
    };
  };
}
