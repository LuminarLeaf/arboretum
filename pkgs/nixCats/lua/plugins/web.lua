local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        superhtml = {},
        cssls = {
          capabilities = capabilities,
        },
        emmet_language_server = {},
      },
    },
  },
}
