{pkgs, ...}: {
  home.packages = [pkgs.superfile];

  home.file.".config/superfile/config.toml".text = ''
    theme = 'catppuccin'
    auto_check_update = false
    cd_on_quit = false
    default_open_file_preview = true
    default_directory = "."
    file_size_use_si = false

    # STYLES
    nerdfont = true
    transparent_background = true
    file_preview_width = 0
    sidebar_width = 20

    # Border style
    border_top = '─'
    border_bottom = '─'
    border_left = '│'
    border_right = '│'
    border_top_left = '╭'
    border_top_right = '╮'
    border_bottom_left = '╰'
    border_bottom_right = '╯'
    border_middle_left = '├'
    border_middle_right = '┤'
  '';
}
