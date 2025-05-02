{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.self.packages.${pkgs.system}.nixCats
  ];

  programs.neovide = {
    enable = true;
    settings.font = {
      normal = ["Maple Mono NF"];
      size = 14;
      features = {"Maple Mono NF" = ["+cv03" "+ss05"];};
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "neovide";
  };
}
