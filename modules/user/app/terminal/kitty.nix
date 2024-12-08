{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font = {
      size = 12;
      name = "MonaspiceNe Nerd Font";
    };
    settings = {
      background_opacity = "0.9";
      background_blur = 1;
      remember_window_size = false;
      initial_window_width = "120c";
      initial_window_height = "30c";
      enable_audio_bell = false;
      hide_window_decorations = "titlebar-only";
      window_padding_width = "1";
      wayland_enable_ime = "no";
      wayland_titlebar_color = "background";

      scrollback_lines = 10000;
      cursor_shape = "beam";
      tab_bar_edge = "bottom";
      tab_bar_style = "slant";
      tab_title_max_length = 30;
      tab_title_template = " {index} {title[title.rfind('/')+1:]}";
      active_tab_title_template = "  {index} {title[title.rfind('/')+1:]}";
      active_tab_font_style = "normal";

      # WIP Keybinds
      # clear_all_shortcuts = "yes";
      # kitty_mod = "alt+shift";
    };
    # keybindings = {
    #   "ctrl+shift+c" = "copy_to_clipboard";
    #   "ctrl+shift+v" = "paste_from_clipboard";
    #
    # };
    catppuccin.enable = true;
  };
}
