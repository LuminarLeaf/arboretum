{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        # MANGOHUD = true;
        OBS_VKCAPTURE = true;
      };
      extraLibraries = pkgs: [pkgs.xorg.libxcb];
    };
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup

    bottles
    wine
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    # GAMEMODERUNEXEC = lib.mkIf (config.hardware.nvidia.modesetting.enable) "nvidia-offload";
  };
}
