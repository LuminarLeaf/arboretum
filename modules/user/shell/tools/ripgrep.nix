{...}: {
  programs = {
    ripgrep.enable = true;
    zsh.shellAliases = {
      grep = "rg";
    };
  };
}
