return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        nixd = {
          formatting = { command = { 'alejandra' } },
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
    },
  },
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = { nix = { 'statix' } },
    },
  },
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      formatters_by_ft = {
        nix = { 'alejandra' },
      },
    },
  },
}
