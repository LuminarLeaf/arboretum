{pkgs, ...}: {
  home.packages = with pkgs; [
    nix-search-tv

    ## yanked from @iynaix
    (writeShellApplication {
      name = "ns";
      runtimeInputs = [fzf nix-search-tv];
      # prevent IFD, thanks @Michael-C-Buckley
      text = ''exec "${pkgs.nix-search-tv.src}/nixpkgs.sh" "$@"'';
    })
    ##
  ];

  xdg.configFile."nix-search-tv/config.json".text = builtins.toJSON {
    indexes = ["nixpkgs" "nixos" "home-manager" "noogle"];
  };
}
