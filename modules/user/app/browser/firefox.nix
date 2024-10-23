{pkgs-unstable, ...}: {
  home.packages = [pkgs-unstable.firefox];

  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs-unstable.firefox}/bin/firefox";
  };
}