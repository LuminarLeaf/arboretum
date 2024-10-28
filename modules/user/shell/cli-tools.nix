{pkgs, ...}: {
  imports = [
    ./tools
  ];

  home.packages = with pkgs; [
    btop
    ripgrep

    jq
    yq

    # dev
    gcc
    go
    rustup
    nodejs
    python3
  ];

  programs.btop = {
    enable = true;
    catppuccin.enable = true;
  };
  programs.zsh.shellAliases."btop" = "btop --utf-force";
}
