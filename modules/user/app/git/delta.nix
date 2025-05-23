{
  lib,
  config,
  ...
}: {
  options = {
    custom.gitDelta = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable git delta";
    };
  };

  config = lib.mkIf config.custom.gitDelta {
    programs.git.extraConfig = {
      merge.conflictStyle = "zdiff3";
      diff.colorMoved = "default";
    };
    programs.git.delta = {
      enable = true;
      options = {
        tabs = 2;
        features = "lynx";
        lynx = {
          dark = true;
          syntax-theme = "Catppuccin Mocha";
          line-numbers = true;

          file-style = "#1e1e2e bold #89b4fa";
          file-decoration-style = "none";

          file-added-label = "[+]";
          file-copied-label = "[C]";
          file-modified-label = "[M]";
          file-renamed-label = "[R]";
          file-removed-label = "[-]";

          hunk-header-style = "file line-number syntax bold italic";
          hunk-header-decoration-style = "#5e81ac bold";
          hunk-header-file-style = "#b4befe ul bold";
          hunk-header-line-number-style = "#fab387 bold";

          line-numbers-plus-style = "brightgreen";
          line-numbers-minus-style = "brightred";
          line-numbers-left-style = "#5e81ac";
          line-numbers-right-style = "#5e81ac";
          line-numbers-zero-style = "#45475a";

          plus-style = "brightgreen black";
          plus-emph-style = "black green";
          minus-style = "brightred black";
          minus-emph-style = "black red";
          zero-style = "syntax";
          whitespace-error-style = "black bold";

          commit-decoration-style = "#cba6f7 ul";

          blame-code-style = "syntax";
          blame-format = "{author:<18} {commit:<8} {timestamp:<15}";
          blame-palette = "#1e1e2e #181825 #313244";
          blame-separator-style = "#74c7ec";

          merge-conflict-begin-symbol = "~";
          merge-conflict-end-symbol = "~";
          merge-conflict-ours-diff-header-style = "yellow bold";
          merge-conflict-ours-diff-header-decoration-style = "#5E81AC box";
          merge-conflict-theirs-diff-header-style = "yellow bold";
          merge-conflict-theirs-diff-header-decoration-style = "#5E81AC box";
        };
      };
    };
  };
}
