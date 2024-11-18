{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    qbittorrent-nox
  ];
  environment.etc = {
    "vuetorrent" = {
      source = inputs.vuetorrent;
      target = "vuetorrent";
    };
  };
}
