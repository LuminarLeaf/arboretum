_: {
  programs.zed-editor = {
    enable = true;
    userSettings = {
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Dark Pro";
      };
      ui_font_family = "Iosevka Aile";
      buffer_font_family = "Iosevka";
      icon_theme = "Zed (Default)";
      buffer_line_height = "standard";
      ui_font_size = 16;
      buffer_font_size = 16;

      auto_update = false;
      autosave = "on_focus_change";
      confirm_quit = true;

      disable_ai = true;
      telemetry = {
        diagnostics = false;
        metrics = false;
        anthropic_retention = false;
      };

      title_bar.show_sign_in = false;
      collaboration_panel.button = false;
      project_panel.entry_spacing = "standard";
      search.button = false;
      debugger.button = false;

      tab_size = 2;
      completion_menu_item_kind = "symbol";
      inlay_hints.enabled = true;

      vim_mode = true;
      vim = {
        toggle_relative_line_numbers = true;
        use_smartcase_find = true;
      };

      which_key = {
        enabled = true;
        delay_ms = 400;
      };

      languages = {
        Nix = {
          language_servers = ["nixd" "!nil"];
        };
      };
      lsp = {};
      auto_install_extensions = {
        html = true;
        nix = true;
        typst = true;
      };
      read_only_files = ["**/*.lock" "**/vendor/**" "**/node_modules/**"];
    };
  };
}
