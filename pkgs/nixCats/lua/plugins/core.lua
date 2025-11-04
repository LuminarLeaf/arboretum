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
  -- TODO: Remove this once tree-sitter is updated and I dont need to pin nixpkgs for nixCats or I move to NVF
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
  {
    'zbirenbaum/copilot.lua',
    opts = {
      filetypes = {
        help = false,
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
            -- disable for .env files
            return false
          end
          return true
        end,
      },
    },
  },
}
