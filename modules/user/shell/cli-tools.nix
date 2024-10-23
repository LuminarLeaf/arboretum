{pkgs, ...}: {
  imports = [
    ./tools
  ];

  home.packages = with pkgs; [
    btop
    ripgrep

    jq
    yq

    # archiving
    rar
    unar
    p7zip
  ];

  programs.btop = {
    enable = true;
    catppuccin.enable = true;
  };
  programs.zsh.shellAliases."btop" = "btop --utf-force";
}
