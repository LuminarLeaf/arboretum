{
  pkgs,
  lib,
  ...
}: let
  aliases = {
    c = "clear";
    less = "less -RF";
    du = "du -had1";
    df = "df -h";
    duf = ''
      ${lib.getExe pkgs.nushell} -c '
      df -h -t vfat -t zfs -t ext4 --output=target,source,fstype,used,avail,size,pcent
        | str replace "Mounted on" Mount | detect columns | sort-by "Mount"'
    '';
    free = "free -h";
    "7z" = "7zz";

    sn = "shutdown now";
    srn = "shutdown -r now";

    zfs-list = "zfs list -o name,used,lused,avail,compressratio";

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
      completionInit = "";
      antidote = {
        enable = true;
        useFriendlyNames = true;
        plugins = [
          # "romkatv/zsh-bench kind:path"

          "mattmc3/ez-compinit"
          "zsh-users/zsh-completions path:src kind:fpath"

          "ohmyzsh/ohmyzsh path:plugins/git"
          "ohmyzsh/ohmyzsh path:plugins/rsync"

          "aloxaf/fzf-tab"
          "catppuccin/zsh-syntax-highlighting path:themes/catppuccin_mocha-zsh-syntax-highlighting.zsh"

          "zsh-users/zsh-syntax-highlighting"
          "zsh-users/zsh-autosuggestions"
        ];
      };
      history = {
        append = true;
        findNoDups = true;
        ignoreAllDups = true;
        ignoreDups = true;
        # ignorePatterns = ["rm *" "pkill *"];
        ignoreSpace = true;
        path = "$HOME/.zsh_history";
        save = 10000;
        saveNoDups = true;
        share = true;
        size = 50000;
      };
      sessionVariables = {
        KEYTIMEOUT = "1";
      };
      initContent = lib.mkMerge [
        (
          lib.mkBefore
          #sh
          ''
            autoload -U select-word-style
            select-word-style bash
          ''
        )

        #sh
        ''
          zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color always $realpath'
          zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --color always $realpath'
          zstyle ':fzf-tab:*' use-fzf-default-opts yes

          bindkey -M viins '^a' beginning-of-line
          bindkey -M viins '^e' end-of-line
          bindkey -M viins '^?' backward-delete-char
          bindkey -M viins '^f' forward-char
          bindkey -M viins '^[b' vi-backward-word
          bindkey -M viins '^[f' vi-forward-word
          bindkey -M viins '^[n' down-line-or-history
          bindkey -M viins '^[p' up-line-or-history
          bindkey -M viins '^[^?' backward-kill-word

          setopt globdots

          autoload edit-command-line
          zle -N edit-command-line
          bindkey -M vicmd vv edit-command-line

          function zle-keymap-select {
            if [[ $KEYMAP == vicmd ]]; then
              echo -ne '\e[2 q'
            else
              echo -ne '\e[6 q'
            fi
          }
          zle -N zle-keymap-select

          # Yank to system clipboard
          function vi-yank-clipboard {
            zle vi-yank
            echo "$CUTBUFFER" | wl-copy
          }
          zle -N vi-yank-clipboard
          bindkey -M vicmd 'y' vi-yank-clipboard

          function ex() {
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

          function mkcd() {
            if [ $# -eq 0 ]; then
              echo "error: no <dir> provided for creation"
              echo "usage: mkcd <dir>"
            fi
            mkdir -p $1 && cd $1
          }

          function e() {
            if [[ -n "$VISUAL" ]]; then
              "$VISUAL" "$@"
            elif [[ -n "$EDITOR" ]]; then
              "$EDITOR" "$@"
            else
              echo "No editor set"
            fi
          }

          function ddiso() {
            dd if=$1 of=$2 status=progress oflag=sync
          }
        ''
      ];
    };
  };
}
