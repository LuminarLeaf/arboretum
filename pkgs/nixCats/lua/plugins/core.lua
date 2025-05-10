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
