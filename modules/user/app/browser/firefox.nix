{pkgs, ...}: {
  home.packages = [pkgs.firefox pkgs.librewolf];

  home.sessionVariables = {
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
    # DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
  };
}
