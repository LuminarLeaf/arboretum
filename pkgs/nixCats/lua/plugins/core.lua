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
