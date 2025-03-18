{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      aleo-fonts
      inter
      roboto
      lato
      geist-font
      lexend
      libertinus
      liberation_ttf

      noto-fonts
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji

      material-symbols

      corefonts
      vistafonts

      monaspace # firefox and other things
      maple-mono

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
        common = ["Monaspace Neon" "Material Symbols" "Symbols Nerd Font" "Noto Color Emoji"];
      in {
        # serif = ["Libertinus Serif"] ++ common;
        # sansSerif = ["Geist"] ++ common;
        serif = common;
        sansSerif = common;
        monospace = common;
        emoji = ["Noto Color Emoji" "Material Symbols"];
      };
    };
  };
}
