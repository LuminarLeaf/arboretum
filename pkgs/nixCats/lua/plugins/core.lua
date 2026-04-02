return {
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin-mocha',
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
  {
    'nvim-treesitter/nvim-treesitter',
    build = require('nixCatsUtils').lazyAdd ':TSUpdate',
    opts_extend = require('nixCatsUtils').lazyAdd(nil, false),
    opts = {
      ensure_installed = require('nixCatsUtils').lazyAdd(
        { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
        {}
      ),
      auto_install = require('nixCatsUtils').lazyAdd(true, false),
      ignore_install = require('nixCatsUtils').lazyAdd(nil, 'all'),
    },
    config = function(_, opts)
      local TS = require 'nvim-treesitter'
      TS.setup(opts)
      LazyVim.treesitter.get_installed(true)

      ---@param buf integer
      ---@param language string
      local function treesitter_try_attach(buf, language)
        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then
          return false
        end
        -- enables syntax highlighting and other treesitter features
        pcall(vim.treesitter.start, buf)

        -- enables treesitter based folds
        if LazyVim.set_default('foldmethod', 'expr') then
          LazyVim.set_default('foldexpr', 'v:lua.LazyVim.treesitter.foldexpr()')
        end

        -- enables treesitter based indentation
        LazyVim.set_default('indentexpr', 'v:lua.LazyVim.treesitter.indentexpr()')

        return true
      end

      local installable_parsers = require('nvim-treesitter').get_available()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('lazyvim_treesitter', { clear = true }),
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          if not treesitter_try_attach(buf, language) then
            if vim.tbl_contains(installable_parsers, language) then
              -- not already installed, so try to install them via nvim-treesitter if possible
              require('nvim-treesitter').install(language):await(function()
                treesitter_try_attach(buf, language)
              end)
            end
          end
        end,
      })
    end,
  },
}
