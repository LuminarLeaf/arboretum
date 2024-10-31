{pkgs, ...}: {
  imports = [
    ./tools
  ];

  home.packages = with pkgs; [
    ripgrep
    jq
    yq
    killall

    yt-dlp
    imagemagick

    neofetch
    onefetch
    microfetch

    # dev
    clang
    go
    rustup
    nodejs
    bun
    python3
  ];

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {cudaSupport = true;};
    catppuccin.enable = true;
  };
  programs.zsh.shellAliases."btop" = "btop --utf-force";
}
