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
      MANPAGER = "bat -plman";
    };
    initContent = ''
      bh() {
        "$@" --help 2>&1 | bat -pl help
      }
      compdef '_command_names -e' bh
    '';
  };
}
