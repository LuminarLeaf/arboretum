{pkgs, ...}: {
  imports = [
    ./tools
  ];

  home.packages = with pkgs; [
    ripgrep
    jq
    yq-go
    killall
    sd
    hyperfine

    yt-dlp
    imagemagick

    fastfetch
    onefetch
    microfetch

    # dev
    gcc
    go
    nodejs
    bun
    python3
  ];

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {cudaSupport = true;};
  };
  catppuccin.btop.enable = true;
}
