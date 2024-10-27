-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M = {
  base46 = {
    theme = "catppuccin",
    transparency = true,
    hl_override = {
      Comment = { italic = true },
      ["@comment"] = { italic = true },
    },
  },

  nvdash = {
    load_on_startup = true,
  },
}

if vim.g.neovide then
  M.base46.transparency = false
end

return M
