{pkgs, ...}: {
  home.packages = [ pkgs.glow ];

  home.file.".config/glow/glow.yml".text = ''
    style: "auto"
    mouse: true
    pager: true
    width: 120
    all: true
  '';
}
