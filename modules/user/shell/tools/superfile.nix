{pkgs, ...}: {
  home.packages = [pkgs.superfile];

  xdg.configFile = {
    "superfile/config.toml".text = ''
      theme = 'catppuccin'
      editor = ""
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

      #plugins
      metadata = false
      enable_md5_checksum = false
    '';

    "superfile/hotkeys.toml".text = ''
      # Global hotkeys (cannot conflict with other hotkeys)
        confirm = ["enter", "right", "l"]
        quit = ["q", "esc"]
      # movement
        list_up = ["up", "k"]
        list_down = ["down", "j"]
      # file panel control
        create_new_file_panel = ["n", ""]
        close_file_panel = ["w", ""]
        next_file_panel = ["tab", "L"]
        previous_file_panel = ["shift+left", "H"]
        toggle_file_preview_panel = ["f", ""]
      # change focus
        focus_on_process_bar = ["p", ""]
        focus_on_sidebar = ["s", ""]
        focus_on_metadata = ["m", ""]
      # create file/directory and rename
        file_panel_item_create = ["ctrl+n", ""]
        file_panel_item_rename = ["ctrl+r", ""]
      # file operations
        copy_items = ["ctrl+c", ""]
        cut_items = ["ctrl+x", ""]
        paste_items = ["ctrl+v", ""]
        delete_items = ["ctrl+d", "delete", ""]
      # compress and extract
        extract_file = ["ctrl+e", ""]
        compress_file = ["ctrl+a", ""]
      # editor
        open_file_with_editor = ["e", ""]
        open_current_directory_with_editor = ["E", ""]
      # other
        pinned_directory = ["P", ""]
        toggle_dot_file = [".", ""]
        change_panel_mode = ["ctrl+L", ""]
        open_help_menu = ["?", ""]
        open_command_line = [":", ""]
        copy_path = ["ctrl+p", ""]
      # Typing hotkeys (can conflict with all hotkeys)
        confirm_typing = ["enter", ""]
        cancel_typing = ["ctrl+c", "esc"]
      # Normal mode hotkeys (can conflict with other modes, cannot conflict with global hotkeys)
        parent_directory = ["h", "left", "backspace"]
        search_bar = ["/", ""]
      # Select mode hotkeys (can conflict with other modes, cannot conflict with global hotkeys)
        file_panel_select_mode_items_select_down = ["shift+down", "J"]
        file_panel_select_mode_items_select_up = ["shift+up", "K"]
        file_panel_select_all_items = ["A", ""]
    '';
  };
}
