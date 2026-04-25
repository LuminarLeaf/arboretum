{
  pkgs,
  inputs,
  ...
}: {
  programs.yazi = {
    enable = true;

    # TODO: remove when changing state version to >26.05
    shellWrapperName = "yy";

    settings = {
      mgr = {
        show_hidden = true;
        show_symlink = false;
        scrolloff = 3;
      };
      plugin = {
        prepend_previewers = [
          {
            url = "*.env";
            run = "noop";
          }
        ];
        prepend_preloaders = [
          {
            name = "/media/ext_wd/**";
            run = "noop";
          }
        ];
      };
    };

    theme.flavor = {
      dark = "catppuccin-mocha";
      light = "catppuccin-latte";
    };

    flavors = {
      catppuccin-mocha = "${inputs.yazi-flavours}/catppuccin-mocha.yazi";
      catppuccin-latte = "${inputs.yazi-flavours}/catppuccin-latte.yazi";
    };

    plugins = {
      inherit (pkgs.yaziPlugins) yatline yatline-catppuccin;
      wl-clipboard = ./wl-clipboard;
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          run = ["plugin wl-clipboard"];
          on = ["<C-y>"];
          desc = "Copy to system clipboard";
        }
        {
          run = [''shell "$SHELL" --block ''];
          on = ["!"];
          desc = "Open $SHELL here";
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
