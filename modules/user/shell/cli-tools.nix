{pkgs, ...}: {
  imports = [
    ./tools
  ];

  home.packages = with pkgs; [
    dust
    dysk
    fx
    hyperfine
    jq
    killall
    ripgrep
    yq-go

    yt-dlp
    imagemagick

    fastfetch
    onefetch
    microfetch

    # dev
    gcc
    go
    nodejs
    python3
    uv
  ];

  catppuccin.btop.enable = true;
  programs = {
    btop = {
      enable = true;
      package = pkgs.btop.override {cudaSupport = true;};
    };

    tealdeer.enable = true;

    nix-index.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
