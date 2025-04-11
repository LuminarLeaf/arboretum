{pkgs, ...}: {
  home.packages = [pkgs.glow];

  catppuccin.glamour.enable = true;

  xdg.configFile."glow/glow.yml".text = ''
    style: "auto"
    mouse: true
    pager: true
    width: 120
    all: true
  '';
}
