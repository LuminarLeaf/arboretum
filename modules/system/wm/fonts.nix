{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      aileron
      aleo-fonts
      comfortaa
      geist-font
      inter
      jost
      lato
      lexend
      liberation_ttf
      libertinus
      roboto

      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji

      material-symbols

      corefonts
      vistafonts

      iosevka-bin
      (iosevka-bin.override {variant = "Slab";})
      (iosevka-bin.override {variant = "Aile";})
      (iosevka-bin.override {variant = "Etoile";})
      monaspace
      maple-mono.NF

      nerd-fonts.monaspace
      nerd-fonts.symbols-only
    ];

    fontDir.enable = true;

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = false;
      };

      defaultFonts = let
        common = ["Material Symbols" "Symbols Nerd Font" "Noto Color Emoji"];
      in {
        serif = ["Monaspace Xenon"] ++ common;
        sansSerif = ["Monaspace Neon"] ++ common;
        monospace = ["Monaspace Krypton"] ++ common;
        emoji = ["Noto Color Emoji" "Material Symbols"];
      };
    };
  };
}
