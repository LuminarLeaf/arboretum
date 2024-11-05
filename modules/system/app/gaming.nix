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
        MANGOHUD = true;
        OBS_VKCAPTURE = true;
      };
      extraLibraries = pkgs: [pkgs.xorg.libxcb];
      # extraPkgs = with pkgs; [ xorg.libXcursor xorg.libXi xorg.libXinerama xorg.libXScrnSaver libpng libpulseaudio libvorbis stdenv.cc.cc.lib libkrb5 keyutils gamemode ];
    };
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup

    (lutris.override {
      # extraLibraries = pkgs: [];
      # extraPkgs = pkgs: [];
    })
    wine
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    GAMEMODERUNEXEC = lib.mkIf (config.hardware.nvidia.modesetting.enable) "nvidia-offload";
  };
}
