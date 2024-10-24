{
  pkgs-stable,
  pkgs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    mouse = true;
    prefix = "C-Space";
    baseIndex = 1;
    clock24 = true;
    # historyLimit = 5000;
    keyMode = "vi";
    # newSession = true;
    sensibleOnTop = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.yank
      tmuxPlugins.vim-tmux-navigator
    ];
    catppuccin = {
      enable = true;
      extraConfig = ''
        set -g @catppuccin_flavor "mocha"
        set -g @catppuccin_menu_selected_style "fg=#{@thm_surface_0},bg=#{@thm_mauve}"
        set -g @catppuccin_status_background "none"

        set -g @catppuccin_window_status_style "custom"
        set -g @catppuccin_window_left_separator ""
        set -g @catppuccin_window_middle_separator " █"
        set -g @catppuccin_window_right_separator "█"
        set -g @catppuccin_window_number_position "right"

        set -g @catppuccin_window_default_background "#{@thm_peach}"
        set -g @catppuccin_window_current_background "#{@thm_sapphire}"

        set -g @catppuccin_pane_border_style "fg=#{@thm_surface_0}"
        set -g @catppuccin_pane_active_border_style "fg=#{@thm_lavender}"

        set -g @catppuccin_status_left_separator  " "
        set -g @catppuccin_status_right_separator ""
        set -g @catppuccin_status_connect_separator "no"

        set -g status-left ""
        set -g status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_directory}"
        set -ag status-right "#{E:@catppuccin_status_session}"
      '';
    };
    # shell = "${pkgs.zsh}/bin/zsh";
    # disableConfirmationPrompt = true;

    # extraConfig = '''';
    # extraConfigBeforePlugins = '''';
  };
  catppuccin.sources.tmux = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "tmux";
    rev = "10aac293a892125ea9f895fd4348ed90baab649d";
    sha256 = "sha256-p0xrk4WXNoVJfekA/L3cxIVrLqjFbBe2S/rc/6JXz6M=";
  };
  # programs.tmux = {
  #   enable = true;
  #   package = pkgs.tmux;
  #   extraConfig = ''
  #     # Enable mouse support
  #     set -g mouse on

  #     # Set prefix
  #     unbind C-b
  #     set -g prefix C-Space
  #     bind C-Space send-prefix

  #     # Shift Alt vim keys to switch windows
  #     bind -n M-H previous-window
  #     bind -n M-L next-window

  #     # Start windows and panes at 1
  #     set -g base-index 1
  #     set -g pane-base-index 1
  #     set-window-option -g pane-base-index 1
  #     set-option -g renumber-windows on

  #     # Enable 24 bit color
  #     set -g default-terminal "tmux-256color"
  #     set -ga terminal-overrides ",*256col*:Tc"
  #     set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
  #     set-environment -g COLORTERM "truecolor"

  #     # Plugins
  #     set -g @plugin 'tmux-plugins/tpm'
  #     set -g @plugin 'tmux-plugins/tmux-sensible'
  #     set -g @plugin 'catppuccin/tmux#v1.0.3'
  #     set -g @plugin 'tmux-plugins/tmux-yank'
  #     set -g @plugin 'christoomey/vim-tmux-navigator'
  #     set -g @plugin 'noscript/tmux-mighty-scroll'
  #     set -g @plugin 'alexwforsythe/tmux-which-key'

  #     # Catppuccin
  #     set -g @catppuccin_flavor "mocha"
  #     set -g @catppuccin_menu_selected_style "fg=#{@thm_surface_0},bg=#{@thm_mauve}"
  #     set -g @catppuccin_status_background "none"

  #     set -g @catppuccin_window_status_style "custom"
  #     set -g @catppuccin_window_left_separator ""
  #     set -g @catppuccin_window_middle_separator " █"
  #     set -g @catppuccin_window_right_separator "█"
  #     set -g @catppuccin_window_number_position "right"

  #     set -g @catppuccin_window_default_background "#{@thm_peach}"
  #     set -g @catppuccin_window_current_background "#{@thm_sapphire}"

  #     set -g @catppuccin_pane_border_style "fg=#{@thm_surface_0}"
  #     set -g @catppuccin_pane_active_border_style "fg=#{@thm_lavender}"

  #     set -g @catppuccin_status_left_separator  " "
  #     set -g @catppuccin_status_right_separator ""
  #     set -g @catppuccin_status_connect_separator "no"

  #     set -g status-left ""
  #     set -g status-right "#{E:@catppuccin_status_application}"
  #     set -ag status-right "#{E:@catppuccin_status_directory}"
  #     set -ag status-right "#{E:@catppuccin_status_session}"

  #     # Set vi mode
  #     set-window-option -g mode-keys vi

  #     # keybindings
  #     bind-key -T copy-mode-vi v send-keys -X begin-selection
  #     bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
  #     bind-key -T copy-mode-vi y send-keys copy-selection-and-cancel

  #     bind-key '"' split-window -v -c "#{pane_current_path}"
  #     bind-key % split-window -h -c "#{pane_current_path}"

  #     # Restore Ctrl-l
  #     bind C-l send-keys 'C-l'

  #     if "test ! -d ~/.tmux/plugins/tpm" \
  #       "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"
  #     run '~/.tmux/plugins/tpm/tpm'
  #   '';
  # };
}
