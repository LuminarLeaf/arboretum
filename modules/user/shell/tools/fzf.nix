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
      colors = {
        "bg+" = "#313244";
        # "bg" = "#1e1e2e"; # comment for transparent bg
        "spinner" = "#f5e0dc";
        "hl" = "#f38ba8";
        "fg" = "#cdd6f4";
        "header" = "#f38ba8";
        "info" = "#cba6f7";
        "pointer" = "#f5e0dc";
        "marker" = "#b4befe";
        "fg+" = "#cdd6f4";
        "prompt" = "#cba6f7";
        "hl+" = "#f38ba8";
        "selected-bg" = "#45475a";
      };
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
}
