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
    python3
    uv

    # yanked from @iynaix
    (writeShellApplication {
      name = "ns";
      runtimeInputs = with pkgs; [fzf nix-search-tv];
      # prevent IFD, thanks @Michael-C-Buckley
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    })
  ];

  xdg.configFile."nix-search-tv/config.json".text = builtins.toJSON {indexes = ["nixpkgs" "nixos" "home-manager" "noogle"];};

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
