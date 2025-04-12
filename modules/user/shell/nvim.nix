{pkgs, ...}: {
  home.packages = with pkgs; [
    # base packages
    neovim
    neovim-remote

    nixd

    vscode-langservers-extracted # html css json eslint

    marksman # md
    markdownlint-cli2
    vale # md lint

    lua-language-server
    stylua

    bash-language-server
    shfmt

    yaml-language-server

    dockerfile-language-server-nodejs
    docker-compose-language-service

    typescript-language-server
    biome # ts js
    vtsls

    rust-analyzer
    bacon # rust lint

    sqls # sql mysql

    pyright # python lsp
    ruff # python formatter + lsp

    gopls # go lsp
    gofumpt

    clang-tools # clangd
  ];

  home.file.".config/nvim" = {
    source = ./neovim;
    recursive = true;
  };
  systemd.user.tmpfiles.rules = [
    "L+ /home/leaf/.config/nvim/lazy-lock.json - - - - /home/leaf/arboretum/modules/user/shell/neovim/lazy-lock.json"
    "L+ /home/leaf/.config/nvim/lazyvim.json - - - - /home/leaf/arboretum/modules/user/shell/neovim/lazyvim.json"
  ];

  programs.neovide = {
    enable = true;
    settings.font = {
      normal = ["Maple Mono NF"];
      size = 14;
      features = {"Maple Mono NF" = ["+cv03" "+ss05"];};
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "neovide";
  };
}
