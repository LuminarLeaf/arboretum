{
  pkgs,
  inputs,
  ...
}: {
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraEnv = {
        # MANGOHUD = true;
        OBS_VKCAPTURE = true;
      };
      extraLibraries = pkgs: [pkgs.libxcb];
    };
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-rs
    gamescope

    # heroic
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.bottles
  ];

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    # GAMEMODERUNEXEC = lib.mkIf (config.hardware.nvidia.modesetting.enable) "nvidia-offload";
  };
}
