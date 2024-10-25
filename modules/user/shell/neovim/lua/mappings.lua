require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- add vim-tmux bindings
-- map("n", "<C-h>", "<CMD> TmuxNavigateLeft<CR>",  {desc = "tmux window left"})
-- map("n", "<C-j>", "<CMD> TmuxNavigateDown<CR>",  {desc = "tmux window down"})
-- map("n", "<C-k>", "<CMD> TmuxNavigateUp<CR>",    {desc = "tmux window up"})
-- map("n", "<C-l>", "<CMD> TmuxNavigateRight<CR>", {desc = "tmux window right"})


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
