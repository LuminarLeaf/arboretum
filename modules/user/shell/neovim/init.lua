-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- neovide settings
if vim.g.neovide then
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_refresh_rate_idle = 15
  vim.g.neovide_cursor_vfx_particle_density = 14
end
