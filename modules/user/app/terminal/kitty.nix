{pkgs, ...}: {
  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    font = {
      size = 11;
      name = "JetBrainsMonoNL Nerd Font";
    };
    settings = {
      background_opacity = "0.75";
      background_blur = 1;
      remember_window_size = true;
      initial_window_width = "120c";
      initial_window_height = "30c";
      enable_audio_bell = false;
      hide_window_decorations = "titlebar-only";
      window_padding_width = "5";
      scrollback_lines = 10000;

      cursor_shape = "beam";
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      wayland_enable_ime = "no";
    };
    catppuccin.enable = true;
  };
}
