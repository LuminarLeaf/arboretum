{pkgs, ...}: {
  imports = [
    ./xdg-mime.nix
    ../../theming
  ];

  home = {
    packages = with pkgs; [
      deadbeef-with-plugins
      haruna
    ];

    sessionVariables.SSH_ASKPASS_REQUIRE = "prefer";
  };
}
