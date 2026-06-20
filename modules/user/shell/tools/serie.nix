{pkgs, ...}: let
  tomlFormat = pkgs.formats.toml {};
in {
  home.packages = [pkgs.serie];

  xdg.configFile."serie/config.toml".source = tomlFormat.generate "serie-config.toml" {
    core = {
      search = {ignore_case = true;};
      user_command = {
        commands_1 = {
          name = "git diff";
          commands = ["sh" "-c" "git diff --color=always {{first_parent_hash}} {{target_hash}} | delta --paging=never --features 'side-by-side lynx' --width {{area_width}}"];
        };
        tab_width = 2;
      };
    };
  };
}
