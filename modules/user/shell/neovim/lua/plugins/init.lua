return {
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    cmd = { "ConformInfo" },
    config = function()
      require "configs.conform"
    end,
  },
  {
    "mfussenegger/nvim-lint",
    -- event = { "BufWritePost", "BufWritePre", "InsertLeave" },
    event = { "BufReadPre", "BufNewFile", "InsertLeave" },
    config = function()
      require "configs.nvim-lint"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "rmagatti/auto-session",
    lazy = false,

    opts = {
      suppressed_dirs = { "~/", "~/Downloads" },
      bypass_save_filetypes = { "alpha", "dashboard", "NVDash" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "vim",
        "vimdoc",
        "lua",
        "luadoc",
        "html",
        "css",
        "javascript",
        "bash",
        "markdown",
        "dockerfile",
        "toml",
        "yaml",
        "json",
        "nix",
        "c",
        "cpp",
        "python",
        "go",
        "rust",
      })
    end,
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
    ft = "markdown",
  },
  -- {
  --   "christoomey/vim-tmux-navigator",
  --   lazy = false,
  -- }
}
