{...}: {
  programs.bat = {
    enable = true;
    config = {
      style = "plain";
      pager = "less -FR";
    };
    catppuccin.enable = true;
  };

  programs.zsh = {
    shellAliases.cat = "bat --style header,snip,changes,numbers";
    localVariables = {
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
      PAGER = "bat";
    };
    initExtra = ''
      bh() {
        "$@" --help 2>&1 | bat -pl help
      }
    '';
  };
}
