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
      completionInit = "";
      antidote = {
        enable = true;
        useFriendlyNames = true;
        plugins = [
          "romkatv/zsh-bench kind:path"

          "mattmc3/ez-compinit"
          "zsh-users/zsh-completions path:src kind:fpath"

          "getantidote/use-omz"
          "ohmyzsh/ohmyzsh path:plugins/git"
          "ohmyzsh/ohmyzsh path:plugins/docker"
          "ohmyzsh/ohmyzsh path:plugins/docker-compose"
          "ohmyzsh/ohmyzsh path:plugins/rsync"
          "ohmyzsh/ohmyzsh path:plugins/sudo"

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
        ignorePatterns = ["rm *" "pkill *"];
        ignoreSpace = true;
        path = "$HOME/.zsh_history";
        save = 10000;
        saveNoDups = true;
        share = true;
        size = 50000;
      };
      initExtraFirst =
        #bash
        ''
          autoload -U select-word-style
          select-word-style bash
        '';
      initExtra =
        #bash
        ''
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color always $realpath'
          zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color always $realpath'
          # HACK: This breaks fzf-tab in tmux for some reason, remove if you want to use tmux AND fzf-tab
          zstyle ':fzf-tab:*' use-fzf-default-opts yes

          bindkey '^a' beginning-of-line
          bindkey '^e' end-of-line
          bindkey '^?' backward-delete-char
          bindkey '^f' forward-char
          bindkey '^[b' vi-backward-word
          bindkey '^[f' vi-forward-word
          bindkey '^[n' down-line-or-history
          bindkey '^[p' up-line-or-history
          bindkey '^[^?' backward-kill-word

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
