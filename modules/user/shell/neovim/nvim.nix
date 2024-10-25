{pkgs, ...}: {
  home.packages = with pkgs; [
    neovim
    neovim-remote
    neovide
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

  home.file.".config/nvim" = {
    source = ./.;
    recursive = true;
  };

  programs.zsh.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "neovide";
  };
}
