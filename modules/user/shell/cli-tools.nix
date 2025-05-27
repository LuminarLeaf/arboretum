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
    (writeScriptBin "ns" (builtins.readFile (fetchurl {
      url = "https://github.com/3timeslazy/nix-search-tv/raw/70e3dae0f790bc6ffce6199e3da967c297e8aea9/nixpkgs.sh";
      hash = "sha256-/TKONYWLxSvCIxP8A2PuIrtabWUkpbJEwZi5vVw6/wk=";
    })))
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
