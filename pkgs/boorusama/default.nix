{
  appimageTools,
  fetchurl,
}:
appimageTools.wrapType2 (finalAttrs: {
  pname = "Boorusama";
  version = "4.6.2";

  src = fetchurl {
    url = "https://github.com/khoadng/Boorusama/releases/download/v${finalAttrs.version}/boorusama-${finalAttrs.version}-linux-x64.AppImage";
    hash = "sha256-tJv5ZVWsqHy79Wux4geWM64DoM2iqNa4mjGEcJJvvqI=";
  };

  extraPkgs = pkgs: [
    pkgs.mpv
    pkgs.libepoxy
    pkgs.lz4.lib
  ];
})
