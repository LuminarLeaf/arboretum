{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.nixCats
  ];

  programs.neovide = {
    enable = true;
    settings.font = {
      normal = ["monospace"];
      size = 14;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "neovide";
  };
}
