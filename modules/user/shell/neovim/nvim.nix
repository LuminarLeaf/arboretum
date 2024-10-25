{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    neovim-remote
    nixd
    marksman
    lua-language-server
    stylua
    bash-language-server
    yaml-language-server
    biome
    typescript-language-server
    dockerfile-language-server-nodejs
    docker-compose-language-service
    vscode-langservers-extracted
    sqls
    nodePackages.prettier
  ];

  programs.neovide = {
    enable = true;
    settings = {};
  };

  home.file.".config/nvim" = {
    source = ./.;
    recursive = true;
  };
}
