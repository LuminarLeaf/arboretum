{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.pkgs =
    (with pkgs; [
      lua-language-server
      typescript-language-server
      docker-compose-language-service
      bash-language-server
      yaml-language-server
      nil
    ])
    ++ (with pkgs-unstable; [
      neovim
      neovide
    ]);

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim" = {
    source = "./config/";
    recursive = true;
  };
}
