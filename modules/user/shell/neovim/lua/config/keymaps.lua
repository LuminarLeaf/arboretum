-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

-- map("t", "<C-x>", "<C-\\><C-n>", { desc = "Exit term mode" })

-- add vim-tmux bindings
-- map("n", "<C-h>", "<CMD> TmuxNavigateLeft<CR>",  {desc = "tmux window left"})
-- map("n", "<C-j>", "<CMD> TmuxNavigateDown<CR>",  {desc = "tmux window down"})
-- map("n", "<C-k>", "<CMD> TmuxNavigateUp<CR>",    {desc = "tmux window up"})
-- map("n", "<C-l>", "<CMD> TmuxNavigateRight<CR>", {desc = "tmux window right"})
