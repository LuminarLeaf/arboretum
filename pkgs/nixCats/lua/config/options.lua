vim.g.ai_cmp = false

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
