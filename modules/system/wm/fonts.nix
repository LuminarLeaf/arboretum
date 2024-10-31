{pkgs, ...}: {
  fonts.packages = with pkgs; [
    inter
    roboto
    noto-fonts
    noto-fonts-emoji
    # font-awesome
    # material-icons
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Hack"
        "Monaspace"
        "JetBrainsMono"
      ];
    })
  ];
}
