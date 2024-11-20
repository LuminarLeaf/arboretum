{pkgs, ...}: {
  home.packages = with pkgs; [
    # base packages
    neovim
    neovim-remote
    # neovide

    nixd
    marksman # md
    vale # md lint
    lua-language-server
    bash-language-server
    yaml-language-server
    typescript-language-server
    dockerfile-language-server-nodejs
    docker-compose-language-service
    vscode-langservers-extracted # html css json eslint
    bacon # rust lint
    sqls # sql mysql
    pyright # python lsp
    black # python formatter
    isort # python formatter
    mypy # python lint
    biome # ts js
    stylua
    # nodePackages.prettier # js ts json css html
    prettierd # ↑
    eslint_d # js
    gopls # go lsp
    clang-tools # clangd
  ];

  # TODO: nvim-dap

  home.file.".config/nvim" = {
    source = ./.;
    recursive = true;
  };

  programs.zsh.sessionVariables = {
    EDITOR = "nvim";
    # VISUAL = "neovide";
  };
}
