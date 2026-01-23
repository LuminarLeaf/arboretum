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
    serie
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
    bun
    python3

    # yanked from @iynaix
    (writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [fzf nix-search-tv];
      # prevent IFD, thanks @Michael-C-Buckley
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    })
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
