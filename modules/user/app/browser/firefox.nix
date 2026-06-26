{pkgs, ...}: {
  home.packages = [
    pkgs.firefox
    pkgs.librewolf
  ];

  #TODO: Declarative firefox/librewolf config
}
