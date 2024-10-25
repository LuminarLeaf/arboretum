{pkgs, ...}: {
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # environment.sessionVariables = {
  #   XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
  # };
}
