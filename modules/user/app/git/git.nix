{userSettings, ...}: {
  imports = [./delta.nix];

  programs = {
    git = {
      enable = true;
      userName = userSettings.name;
      userEmail = userSettings.git_email;
      extraConfig = {
        init.defaultBranch = "main";
        merge.conflictStyle = "diff3";
        diff.colorMoved = "default";
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
  };
}
