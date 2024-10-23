# {defaultCommand ? "find . -regextype 'posix-extended' -iregex '(\.git(?!ignore|modules)|node_modules|cache).*' -type d -prune -o -print", ...}:
{...}: let
  FZF_DEFAULT_COMMAND = "fd --hidden --strip-cwd-prefix -E .git -E node_modules -E .cache";
  FZF_ALT_C_COMMAND = "fd --type d --hidden --strip-cwd-prefix -E .git -E node_modules -E .cache";
  defaultOptions = [
    # "--layout=reverse"
    "--border"
    "--prompt='❱ '"
  ];
in {
  programs.fzf = {
    enable = true;
    catppuccin.enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
    defaultCommand = FZF_DEFAULT_COMMAND;
    # defaultOptions = defaultOptions;
    inherit defaultOptions;
    fileWidgetCommand = FZF_DEFAULT_COMMAND;
    changeDirWidgetCommand = FZF_ALT_C_COMMAND;
  };
  programs.zsh = {
    initExtra = ''
      _fzf_compgen_path() {
        fd --hidden -E .git -E node_modules -E .cache . "$1"
      }
      _fzf_compgen_dir() {
        fd --dir --hidden -E .git -E node_modules -E .cache . "$1"
      }
    '';
    # localVariables = {
    #   FZF_DEFAULT_COMMAND = FZF_DEFAULT_COMMAND;
    #   FZF_DEFAULT_OPTS = builtins.concatStringsSep " " (defaultOptions
    #     ++ [
    #       "--color=spinner:#f5e0dc,hl:#f38ba8"
    #       "--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc"
    #       "--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
    #     ]);
    #   FZF_CTRL_T_COMMAND = FZF_DEFAULT_COMMAND;
    #   FZF_ALT_C_COMMAND = FZF_ALT_C_COMMAND;
    # };
  };
}
