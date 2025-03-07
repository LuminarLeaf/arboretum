{...}: let
  aliases = {
    c = "clear";
    less = "less -RF";
    du = "du -had1";
    df = "df -h";
    free = "free -h";

    sn = "shutdown now";
    srn = "shutdown -r now";

    zfs-list = "zfs list -o name,used,avail,compressratio,mountpoint";

    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";
  };
in {
  programs = {
    bash = {
      enable = true;
      shellAliases = aliases;
    };

    zsh = {
      enable = true;
      shellAliases = aliases;
      defaultKeymap = "viins";
      antidote = {
        enable = true;
        useFriendlyNames = true;
        plugins = [
          "catppuccin/zsh-syntax-highlighting path:themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"

          "zsh-users/zsh-syntax-highlighting"
          "zsh-users/zsh-completions"
          "zsh-users/zsh-autosuggestions"
          "aloxaf/fzf-tab"

          "getantidote/use-omz"
          "ohmyzsh/ohmyzsh path:plugins/git kind:defer"
          "ohmyzsh/ohmyzsh path:plugins/docker kind:defer"
          "ohmyzsh/ohmyzsh path:plugins/docker-compose kind:defer"
          "ohmyzsh/ohmyzsh path:plugins/rsync kind:defer"
          "ohmyzsh/ohmyzsh path:plugins/sudo kind:defer"
        ];
      };
      history = {
        ignoreAllDups = true;
        ignoreDups = true;
        ignorePatterns = ["rm *" "pkill *"];
        ignoreSpace = true;
        path = "$HOME/.zsh_history";
        save = 10000;
        share = true;
        size = 50000;
      };
      initExtraFirst =
        #bash
        ''
          # needs to be loaded before zsh-syntax-highlighting
          autoload -U select-word-style
          select-word-style bash
        '';
      initExtra =
        #bash
        ''
          setopt APPEND_HISTORY
          setopt HIST_FIND_NO_DUPS

          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
          zstyle ':completion:*' list-colors "$\{(s.:.)LS_COLORS}"
          zstyle ':completion:*' menu no
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color always $realpath'
          zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color always $realpath'

          bindkey '^a' beginning-of-line
          bindkey '^e' end-of-line
          bindkey '^?' backward-delete-char
          bindkey '^f' forward-char
          bindkey '^[b' vi-backward-word
          bindkey '^[f' vi-forward-word
          bindkey '^[n' down-line-or-history
          bindkey '^[p' up-line-or-history
          bindkey '^[^?' backward-kill-word

          # HACK: This breaks fzf-tab in tmux for some reason, remove if you want to use tmux AND fzf-tab
          zstyle ':fzf-tab:*' use-fzf-default-opts yes

          check() {
            if command -v $1 &> /dev/null; then return 0; else return 1; fi
          }

          ex() {
            if [ $# -eq 0 ]; then
              echo "error: no <file> provided for extraction"
              echo "usage: ex <file>"
            fi
            while [ $# -ne 0 ]; do
              if [ ! -f $1 ]; then
                echo "'$1' is not a valid file"
              fi
              case $1 in
                *.tar.bz2) tar xjf $1 ;;
                *.tar.gz) tar xzf $1 ;;
                *.tbz2) tar xjf $1 ;;
                *.tgz) tar xzf $1 ;;
                *.tar) tar xf $1 ;;
                *.bz2) bunzip2 $1 ;;
                *.rar) unrar x $1 ;;
                *.gz) gunzip $1 ;;
                *.zip) unzip $1 ;;
                *.Z) uncompress $1 ;;
                *.7z) 7z x $1 ;;
                *) echo "'$1' cannot be extracted via ex()" ;;
              esac
              shift
            done
          }

          mkcd() {
            if [ $# -eq 0 ]; then
              echo "error: no <dir> provided for creation"
              echo "usage: mkcd <dir>"
            fi
            mkdir -p $1 && cd $1
          }

          e() {
            if [[ -n "$VISUAL" ]]; then
              "$VISUAL" "$@"
            elif [[ -n "$EDITOR" ]]; then
              "$EDITOR" "$@"
            else
              echo "No editor set"
            fi
          }

          ddiso() {
            dd if=$1 of=$2 status=progress oflag=sync
          }
        '';
    };
  };
}
