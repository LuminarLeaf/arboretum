{
  pkgs,
  inputs,
  ...
}: {
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      autoSkipVideo
      beautifulLyrics
      copyToClipboard
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [
      betterLibrary
      lyricsPlus
      newReleases
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
