
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  "html", "cssls", "ts_ls", "biome",
  "marksman", "dockerls", "docker_compose_language_service", "jsonls",
  "bashls", "yamlls", "sqls"
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      formatting = { command = { "alejandra" }, },
      options = {
        nixos = {
          expr = "(builtins.getFlake \"/home/leaf/arboretum\").nixosConfigurations.maple.options",
        },
        home_manager = {
          expr = "(builtins.getFlake \"/home/leaf/arboretum\").homeConfigurations.leaf.options",
        },
      },
    },
  },
})
