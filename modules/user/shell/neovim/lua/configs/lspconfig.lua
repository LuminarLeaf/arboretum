require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  "html",
  "cssls",
  "biome",
  "ts_ls",
  -- "lua_ls",
  "marksman",
  "dockerls",
  "docker_compose_language_service",
  "jsonls",
  "bashls",
  "yamlls",
  "sqls",
  "pyright",
  "clangd",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagonostics = { globals = { "vim", "require" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
}

lspconfig.nixd.setup {
  cmd = { "nixd" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "nix" },
  settings = {
    nixd = {
      formatting = { command = { "alejandra" } },
      options = {
        nixos = {
          expr = '(builtins.getFlake "/home/leaf/arboretum").nixosConfigurations.maple.options',
        },
        home_manager = {
          expr = '(builtins.getFlake "/home/leaf/arboretum").homeConfigurations.leaf.options',
        },
      },
    },
  },
}
