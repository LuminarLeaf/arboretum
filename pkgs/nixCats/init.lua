-- NOTE: this just gives nixCats global command a default value
-- so that it doesnt throw an error if you didnt install via nix.
-- usage of both this setup and the nixCats command is optional,
-- but it is very useful for passing info from nix to lua so you will likely use it at least once.
require('nixCatsUtils').setup {
  non_nix_value = true,
}

-- NOTE: You might want to move the lazy-lock.json file
local function getlockfilepath()
  if require('nixCatsUtils').isNixCats and type(nixCats.settings.unwrappedCfgPath) == 'string' then
    return nixCats.settings.unwrappedCfgPath .. '/lazy-lock.json'
  else
    return vim.fn.stdpath 'config' .. '/lazy-lock.json'
  end
end
local lazyOptions = {
  lockfile = getlockfilepath(),
}

-- NOTE: this the lazy wrapper. Use it like require('lazy').setup() but with an extra
-- argument, the path to lazy.nvim as downloaded by nix, or nil, before the normal arguments.
require('nixCatsUtils.lazyCat').setup(nixCats.pawsible { 'allPlugins', 'start', 'lazy.nvim' }, {
  { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },

  { import = 'lazyvim.plugins.extras.ai.copilot-chat' },
  { import = 'lazyvim.plugins.extras.coding.blink' },
  { import = 'lazyvim.plugins.extras.coding.yanky' },
  { import = 'lazyvim.plugins.extras.dap.core' },
  { import = 'lazyvim.plugins.extras.editor.harpoon2' },
  { import = 'lazyvim.plugins.extras.editor.neo-tree' },
  { import = 'lazyvim.plugins.extras.editor.snacks_picker' },
  { import = 'lazyvim.plugins.extras.formatting.biome' },
  { import = 'lazyvim.plugins.extras.formatting.black' },
  { import = 'lazyvim.plugins.extras.lang.clangd' },
  { import = 'lazyvim.plugins.extras.lang.docker' },
  { import = 'lazyvim.plugins.extras.lang.git' },
  { import = 'lazyvim.plugins.extras.lang.go' },
  { import = 'lazyvim.plugins.extras.lang.json' },
  { import = 'lazyvim.plugins.extras.lang.markdown' },
  { import = 'lazyvim.plugins.extras.lang.python' },
  { import = 'lazyvim.plugins.extras.lang.tex' },
  { import = 'lazyvim.plugins.extras.lang.toml' },
  { import = 'lazyvim.plugins.extras.lang.typescript' },
  { import = 'lazyvim.plugins.extras.lang.yaml' },
  { import = 'lazyvim.plugins.extras.ui.treesitter-context' },
  { import = 'lazyvim.plugins.extras.util.dot' },
  { import = 'lazyvim.plugins.extras.util.mini-hipatterns' },

  { 'williamboman/mason-lspconfig.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { 'williamboman/mason.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },
  { 'jay-babu/mason-nvim-dap.nvim', enabled = require('nixCatsUtils').lazyAdd(true, false) },
  {
    'folke/lazydev.nvim',
    opts = { library = { { path = (nixCats.nixCatsPath or '') .. '/lua', words = { 'nixCats' } } } },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = require('nixCatsUtils').lazyAdd ':TSUpdate',
    opts_extend = require('nixCatsUtils').lazyAdd(nil, false),
    opts = {
      ensure_installed = require('nixCatsUtils').lazyAdd(
        { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
        false
      ),
      auto_install = require('nixCatsUtils').lazyAdd(true, false),
      ignore_install = require('nixCatsUtils').lazyAdd(nil, 'all'),
    },
  },
  -- import/override with your plugins
  { import = 'plugins' },
}, lazyOptions)

if vim.g.neovide then
  -- Display
  -- vim.o.guifont = "Maple Mono NF:h12:#h-none"
  vim.g.neovide_opacity = 1
  vim.g.neovide_floating_corner_radius = 0.25
  vim.g.neovide_hide_mouse_when_typing = true

  -- Functionality
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_refresh_rate_idle = 10

  -- Cursor
  vim.g.neovide_cursor_vfx_mode = 'pixiedust'
  vim.g.neovide_cursor_vfx_particle_density = 10
end
