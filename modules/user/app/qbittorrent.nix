{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    qbittorrent-nox
  ];
  xdg.configFile."vuetorrent" = {
    source = inputs.vuetorrent;
    target = "vuetorrent";
  };
  systemd.user.services = {
    "qbittorrent-nox" = {
      Unit = {
        Description = "qBittorrent-nox Daemon Service";
        Documentation = ["man:qbittorrent-nox(1)"];
        After = ["network-online.target"];
      };

      Service = {
        Type = "simple";
        Restart = "no";
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=54870";
        WorkingDirectory = "%h/.config/qBittorrent";
      };

      Install.WantedBy = [];
    };
  };
}
