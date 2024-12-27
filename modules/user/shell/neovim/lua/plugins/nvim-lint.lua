return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "biomejs " },
        typescript = { "biomejs " },
        javascriptreact = { "biomejs " },
        typescriptreact = { "biomejs " },
        -- python = { "ruff" },
      },
    },
  },
}
