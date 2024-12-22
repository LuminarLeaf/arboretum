{...}: {
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      tmux.enableShellIntegration = true;
      defaultCommand = "fd --hidden --strip-cwd-prefix -E .git -E node_modules -E .cache";
      defaultOptions = [
        "--layout=reverse"
        "--border"
        "--prompt='❱ '"
      ];
      fileWidgetCommand = "fd --hidden --strip-cwd-prefix -E .git -E node_modules -E .cache";
      changeDirWidgetCommand = "fd --type d --hidden --strip-cwd-prefix -E .git -E node_modules -E .cache";
    };
    zsh = {
      initExtra = ''
        _fzf_compgen_path() {
          fd --hidden -E .git -E node_modules -E .cache . "$1"
        }
        _fzf_compgen_dir() {
          fd --dir --hidden -E .git -E node_modules -E .cache . "$1"
        }
      '';
    };
  };
  catppuccin.fzf.enable = true;
}
