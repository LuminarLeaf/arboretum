{
  pkgs,
  inputs,
  ...
}: {
  programs.yazi = {
    enable = true;

    # TODO: remove when changing state version to >26.05
    shellWrapperName = "yy";

    extraPackages = [pkgs.allmytoes];

    settings = {
      mgr = {
        sort_by = "natural";
        show_hidden = true;
        show_symlink = false;
      };
      plugin = {
        prepend_fetchers = [
          {
            url = "/media/ext_wd/**";
            run = "mime-ext.local";
            prio = "high";
            group = "mime";
          }
        ];
        prepend_previewers = [
          {
            url = "*.env";
            run = "noop";
          }
          {
            mime = "image/{hei?,jxl}";
            run = "magick";
          }
          {
            mime = "image/*";
            run = "allmytoes";
          }
        ];
        prepend_preloaders = [
          {
            url = "/media/ext_wd/**";
            run = "noop";
          }
          {
            mime = "image/{hei?,jxl}";
            run = "magick";
          }
          {
            mime = "image/*";
            run = "allmytoes";
          }
        ];
      };
    };

    theme = {
      flavor = {
        dark = "catppuccin-mocha";
        light = "catppuccin-latte";
      };
      indicator.padding = {
        open = "█";
        close = "█";
      };
    };

    flavors = {
      catppuccin-mocha = "${inputs.yazi-flavours}/catppuccin-mocha.yazi";
      catppuccin-latte = "${inputs.yazi-flavours}/catppuccin-latte.yazi";
    };

    plugins = {
      inherit
        (pkgs.yaziPlugins)
        yatline
        yatline-catppuccin
        wl-clipboard
        toggle-pane
        mime-ext
        ;
      allmytoes = {
        package = pkgs.yaziPlugins.allmytoes;
        setup = true;
        settings.sizes = ["x"];
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          run = [''shell "$SHELL" --block ''];
          on = ["!"];
          desc = "Open $SHELL here";
        }

        # plugins
        {
          run = ["plugin wl-clipboard"];
          on = ["<C-y>"];
          desc = "Copy to system clipboard";
        }
        {
          run = ["plugin toggle-pane max-preview"];
          on = ["<C-t>" "p"];
          desc = "Maximize or restore the preview pane";
        }
        {
          run = ["plugin toggle-pane min-preview"];
          on = ["<C-t>" "P"];
          desc = "Show or hide the preview pane";
        }
      ];
    };

    initLua =
      #lua
      ''
        local catppuccin_theme = require("yatline-catppuccin"):setup("mocha")

        local hostname = ya.host_name() or "unknown"

        require("yatline"):setup({
        	theme = catppuccin_theme,
        	show_background = true,

        	section_separator = { open = "", close = "" },
        	part_separator = { open = "│", close = "│" },
        	inverse_separator = { open = "", close = "" },

        	tab_width = 0,

        	header_line = {
        		left = {
        			section_a = { { type = "line", custom = false, name = "tabs", params = { "left" } } },
        			section_b = { { type = "string", custom = false, name = "tab_path" } },
        			section_c = {},
        		},
        		right = {
        			section_a = { { type = "string", custom = true, name = hostname } },
        			section_b = { { type = "coloreds", custom = false, name = "count", params = { false, true } } },
        			section_c = { { type = "coloreds", custom = false, name = "task_states", params = { true } } },
        		},
        	},

        	status_line = {
        		left = {
        			section_a = { { type = "string", custom = false, name = "tab_mode" } },
        			section_b = { { type = "string", custom = false, name = "hovered_size" } },
        			section_c = { { type = "string", custom = false, name = "hovered_name", params = { false, nil, nil, true } } },
        		},
        		right = {
        			section_a = { { type = "string", custom = false, name = "cursor_position" } },
        			section_b = { { type = "string", name = "cursor_percentage" } },
        			section_c = {
        				{ type = "coloreds", custom = false, name = "permissions" },
        				{ type = "string", custom = false, name = "hovered_ownership" },
        			},
        		},
        	},
        })
      '';
  };
}
