{...}: {
  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    extraOptions = ["--group-directories-first"];
    # icons = true;
  };

  programs.zsh.shellAliases = {
    l = "eza -F auto";
    ls = "eza";
    la = "eza -a";
    ll = "eza -lg";
    lla = "eza -lag";
    tree = "eza -T --git-ignore -I '.git|node_modules|.cache|.vscode|.idea'";
  };
}
