{
  appimageTools,
  fetchurl,
}:
appimageTools.wrapType2 (finalAttrs: {
  pname = "Boorusama";
  version = "4.6.1";

  src = fetchurl {
    url = "https://github.com/khoadng/Boorusama/releases/download/v${finalAttrs.version}/boorusama-${finalAttrs.version}+188-linux-x64.AppImage";
    hash = "sha256-D65TDPpN+vNxPDJJUfVzAP1SfqXbPf+NSh/sFbNVhIk=";
  };

  extraPkgs = pkgs: [
    pkgs.mpv
    pkgs.libepoxy
    pkgs.lz4.lib
  ];
})
