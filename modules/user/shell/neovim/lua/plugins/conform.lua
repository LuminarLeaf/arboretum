return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
        typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
        json = { "jq", "biome", "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "markdownlint-cli2" },
        python = { "ruff" },
        go = { "goimports", "gofumpt" },
        rust = { "rust-analyzer", lsp_format = "fallback" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        nix = { "alejandra" },
      },
      formatters = {
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
    },
  },
}
