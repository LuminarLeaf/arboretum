{
  pkgs,
  userSettings,
  ...
}: {
  imports = [./delta.nix];

  home.packages = [pkgs.git pkgs.gh pkgs.gh-dash];
  programs = {
    git = {
      enable = true;
      userName = userSettings.name;
      userEmail = userSettings.git_email;
      extraConfig = {
        init.defaultBranch = "main";
        merge.conflictStyle = "diff3";
        diff.colorMoved = "default";
      };
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
    gh-dash = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}
