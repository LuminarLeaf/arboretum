{...}: {
  programs.bat = {
    enable = true;
    config = {
      style = "plain";
      pager = "less -FR";
    };
  };
  catppuccin.bat.enable = true;

  programs.zsh = {
    shellAliases.cat = "bat --style header,snip,changes,numbers";
    sessionVariables = {
      # MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANPAGER = ''sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman' '';
      PAGER = "bat";
    };
    initExtra = ''
      bh() {
        "$@" --help 2>&1 | bat -pl help
      }
      compdef '_command_names -e' bh
    '';
  };
}
