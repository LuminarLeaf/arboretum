{...}: {
  programs.ripgrep.enable = true;
  programs.zsh.shellAliases = {
    grep = "rg";
  };
}
