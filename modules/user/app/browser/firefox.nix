{pkgs, ...}: {
  home.packages = [pkgs.firefox];

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  };
}
