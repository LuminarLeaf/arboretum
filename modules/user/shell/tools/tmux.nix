{
  pkgs,
  inputs,
  ...
}: {
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    extraConfig =
      #tmux
      ''
        # Change prefix to space
        unbind C-b
        set -g prefix C-Space
        bind C-Space send-prefix

        # True Color
        set -s default-terminal "tmux-256color"
        set -sa terminal-overrides ",xterm-256color:Tc"

        # Start indices from 1
        set -g base-index 1
        set -gw pane-base-index 1
        set -g renumber-windows on

        set -gw mode-keys vi

        set -g status-position top
        set -g status-left-length 100
        set -g status-left ""
        set -g status-right-length 100
        set -g status-right ""

        set -s focus-events on
        set -s set-clipboard on
        set -s escape-time 20
        set -g set-titles on
        set -g display-time 4000
        set -g history-limit 50000
        set -g mouse on
        set -g status-interval 5
        set -g status-keys emacs
        set -gw aggressive-resize on

        # keybindings
        bind -n 'M-:' previous-window
        bind -n 'M-"' next-window

        bind -n M-H select-pane -L
        bind -n M-J select-pane -D
        bind -n M-K select-pane -U
        bind -n M-L select-pane -R

        bind -n C-M-h resize-pane -L 5
        bind -n C-M-j resize-pane -D 5
        bind -n C-M-k resize-pane -U 5
        bind -n C-M-l resize-pane -R 5

        unbind -T copy-mode-vi MouseDragEnd1Pane

        bind W new-window -c "#{pane_current_path}"
        bind C-w new-window -a -c "#{pane_current_path}"

        bind '"' split-window -v -c "#{pane_current_path}"
        bind _ split-window -v -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind | split-window -h -c "#{pane_current_path}"

        bind C-l send-keys 'C-l'

        bind -T copy-mode-vi v send-keys -X begin-selection
        bind -T copy-mode-vi "C-v" send-keys -X rectangle-toggle
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel

        # Status Left
        set -ga status-left "#[bg=#{?client_prefix,#{@thm_sapphire},#{?pane_in_mode,#{@thm_yellow},#{?pane_synchronized,#{@thm_red},#{@thm_lavender}}}},fg=#{@thm_bg}]  #S "
        set -ga status-left "#[bg=#{@thm_green},fg=#{@thm_bg}]  #{pane_current_command} "
        set -ga status-left "#[bg=#{@thm_red},fg=#{@thm_bg}]#{?window_zoomed_flag,  zoom ,}"

        # Status Right
        set -ga status-right "#[bg=#{@thm_maroon},fg=#{@thm_bg}] 󰅐 %H:%M "
        set -ga status-right "#[bg=#{@thm_pink},fg=#{@thm_bg}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "

        # Status Windows
        set -gw status-justify absolute-centre
        set -gw automatic-rename on
        set -gw automatic-rename-format ""

        set -g message-style "bg=#{@thm_bg},fg=#{@thm_white},bold"
        set -g mode-style "bg=#{@thm_lavender},fg=#{@thm_bg}"

        set -g window-status-format " #I#{?#{!=:#{window_name},},: #W,} "
        set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_lavender}"
        set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_mauve}"
        set -g window-status-activity-style "bg=#{@thm_pink},fg=#{@thm_bg}"
        set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
        set -gF window-status-separator "#[fg=#{@thm_overlay_0}]|"

        set -g window-status-current-format " #I#{?#{!=:#{window_name},},: #W,} "
        set -g window-status-current-style "bg=#{@thm_mauve},fg=#{@thm_bg},bold"
      '';
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_status_background "none"
          set -g @catppuccin_window_status_style "none"
          set -g @catppuccin_pane_status_enabled "off"
          set -g @catppuccin_pane_border_status "off"
        '';
      }
      {
        plugin = pkgs.tmuxPlugins.fingers;
        extraConfig = ''
          set -g @fingers-key f
        '';
      }
      inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.tmux-mighty-scroll
    ];
  };
}
