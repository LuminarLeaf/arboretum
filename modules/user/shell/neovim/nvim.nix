{pkgs, ...}: {
  home.packages = with pkgs; [
    # base packages
    neovim
    neovim-remote
    neovide

    nixd
    marksman # md
    vale # md lint
    lua-language-server
    bash-language-server
    yaml-language-server
    typescript-language-server
    dockerfile-language-server-nodejs
    docker-compose-language-service
    rust-analyzer
    vscode-langservers-extracted # html css json eslint
    bacon # rust lint
    sqls # sql mysql
    pyright # python lsp
    ruff # python formatter + lsp
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

  programs.neovide.enable = true;
  programs.neovide.settings = {
    fork = false;
    theme = "auto";
    font = {
      normal = ["MonaspiceNe Nerd Font"];
      size = 12.0;
    };
    font.features = {
      "MonaspiceNe Nerd Font" = ["+calt" "-liga" "-ss01" "-ss02" "-ss03" "-ss04" "-ss05" "-ss06" "-ss07" "-ss08" "-ss09"];
    };
  };

  programs.zsh.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "neovide";
  };
}
