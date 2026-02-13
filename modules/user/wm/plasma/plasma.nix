{pkgs, ...}: {
  imports = [
    ./xdg-mime.nix
    ../../theming
  ];

  home = {
    packages = with pkgs; [
      exaile
      haruna
    ];

    sessionVariables.SSH_ASKPASS_REQUIRE = "prefer";
  };
}
