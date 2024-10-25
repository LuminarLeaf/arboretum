return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "vimdoc", "lua", "luadoc",
        "html", "css", "javascript",
        "bash", "markdown", "dockerfile",
        "toml", "yaml", "json",
        "nix"
      },
    },
  },
  -- {
  --   "christoomey/vim-tmux-navigator",
  --   lazy = false,
  -- }
}
