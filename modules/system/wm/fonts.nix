{pkgs, ...}: {
  fonts.packages = with pkgs; [
    inter
    noto-fonts
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "Hack"
        "SourceCodePro"
        "Meslo"
        "JetBrainsMono"
      ];
    })
  ];
}
