{userSettings, ...}: {
  imports = [./delta.nix];

  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          inherit (userSettings) name;
          email = userSettings.git_email;
        };
        init.defaultBranch = "main";
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/id_ed25519.pub";
        url = {
          "git@github.com:" = {insteadOf = "gh:";};
          "git@github.com:LuminarLeaf/" = {insteadOf = "ll:";};
        };
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
