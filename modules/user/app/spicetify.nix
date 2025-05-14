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
      # copyToClipboard
      hidePodcasts
      queueTime
      shuffle
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
    enabledSnippets = with spicePkgs.snippets; [
      hideDownloadButton
      hideFriendActivityButton
      hideLyricsButton
      hideMiniPlayerButton
      hideNowPlayingViewButton
      modernScrollbar
      removeGradient
      roundedButtons
      roundedImages
      smoothProgressBar
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };
}
