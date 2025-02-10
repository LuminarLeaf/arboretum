{pkgs, ...}: {
  fonts.packages =
    (with pkgs; [
      inter
      roboto
      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-emoji
      corefonts
      vistafonts
      monaspace # firefox and other things
    ])
    ++ (with pkgs.nerd-fonts; [
      monaspace
    ]);
}
