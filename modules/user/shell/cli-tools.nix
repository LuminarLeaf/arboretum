{pkgs, ...}: {
  imports = [
    ./tools
  ];

  home.packages = with pkgs; [
    dysk
    dust
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

    nix-search-tv
    (writeScriptBin "ns" (builtins.readFile "${nix-search-tv.src}/nixpkgs.sh"))
  ];

  programs.btop = {
    enable = true;
    package = pkgs.btop.override {cudaSupport = true;};
  };
  catppuccin.btop.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
