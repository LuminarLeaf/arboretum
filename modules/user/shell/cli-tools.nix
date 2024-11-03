{pkgs, ...}: {
  imports = [
    ./tools
  ];

  home.packages = with pkgs; [
    ripgrep
    jq
    yq-go
    killall

    yt-dlp
    imagemagick

    neofetch
    onefetch
    microfetch

    # dev
    gcc
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
