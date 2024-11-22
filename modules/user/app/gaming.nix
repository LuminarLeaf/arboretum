{pkgs, ...}: {
  home.packages = with pkgs; [
    (prismlauncher.override {
      jdks = [
        zulu8
        (zulu8.overrideAttrs {
          pname = "zulu8-forge";
          version = "8.0.312";
          src = pkgs.fetchurl {
            url = "https://cdn.azul.com/zulu/bin/zulu8.58.0.13-ca-jdk8.0.312-linux_x64.tar.gz";
            hash = "sha256-c0F0iPpLf3+MDFlA2r6oeQiymiPh7myUiy8MqLmvIx0=";
          };
        })
        zulu17
        zulu21
      ];
    })
  ];

  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    output_folder=~/.config/MangoHud/logs/
    toggle_hud=Shift_R+F12
    toggle_logging=Shift_L+F12
    toggle_fps_limit=F1
    upload_log=F5
    media_player_name=spotify
    legacy_layout=false

    round_corners=10
    font_size=24
    position=top-left

    background_color=020202
    background_alpha=0.4
    text_color=FFFFFF
    media_player_color=FFFFFF
    cpu_color=2E97CB
    vram_color=AD64C1
    ram_color=C26693
    engine_color=EB5B5B
    gpu_color=2E9762
    wine_color=EB5B5B
    frametime_color=00FF00
    cpu_text=CPU
    gpu_text=GPU

    fps
    cpu_stats
    cpu_temp
    cpu_power
    cpu_mhz
    gpu_status
    gpu_temp
    gpu_core_clock
    gpu_mem_clock
    gpu_power
    vram
    ram
    frame_timing=1
  '';
}
