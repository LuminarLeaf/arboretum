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
          local basename = vim.fs.basename(vim.api.nvim_buf_get_name(0))
          if
            string.match(basename, '^%.env')
            or string.match(basename, '%.env$')
            or string.match(basename, '%.env%.')
          then
            return false
          end
          return true
        end,
      },
    },
  },
}
