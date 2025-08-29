return {
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
  {
    'catppuccin/nvim',
    opts = { term_colors = true },
  },
  -- TODO: Remove this once https://github.com/LazyVim/LazyVim/pull/6354 is merged or I move to nvf
  {
    'akinsho/bufferline.nvim',
    init = function()
      local bufline = require 'catppuccin.groups.integrations.bufferline'
      bufline.get = bufline.get_theme
    end,
  },
  {
    'folke/which-key.nvim',
    opts = {
      preset = 'classic',
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      diagnostics = {
        virtual_text = {
          prefix = 'icons',
        },
      },
    },
  },
  {
    'folke/snacks.nvim',
    opts = {
      dashboard = {
        preset = {
          header = [[
                                                                    
       ████ ██████           █████      ██                    
      ███████████             █████                            
      █████████ ███████████████████ ███   ███████████  
     █████████  ███    █████████████ █████ ██████████████  
    █████████ ██████████ █████████ █████ █████ ████ █████  
  ███████████ ███    ███ █████████ █████ █████ ████ █████ 
 ██████  █████████████████████ ████ █████ █████ ████ ██████]],
        },
      },
      picker = {
        sources = {
          files = { hidden = true, ignore = true },
          grep = { hidden = true, ignore = true },
        },
      },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      filesystem = {
        filtered_items = { hide_dotfiles = false },
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
      },
    },
  },
}
