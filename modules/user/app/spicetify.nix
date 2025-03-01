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
      beautifulLyrics
      copyToClipboard
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
    enabledSnippets = with spicePkgs.snippets; [
      removeGradient
      roundedImages
      smoothPlaylistRevealGradient
      smoothProgressBar
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
