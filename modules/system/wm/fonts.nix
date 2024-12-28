{pkgs, ...}: {
  fonts.packages =
    (with pkgs; [
      inter
      roboto
      noto-fonts
      noto-fonts-emoji
      monocraft
      corefonts
      vistafonts
    ])
    ++ (with pkgs.nerd-fonts; [
      caskaydia-cove
      fira-code
      hack
      jetbrains-mono
      monaspace
      zed-mono
    ]);
}
