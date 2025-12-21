{pkgs, ...}: {
  home.packages = with pkgs; [
    (prismlauncher.override {
      jdks = [
        (zulu8.overrideAttrs {
          pname = "zulu8-minecraft";
          version = "8.0.312";
          src = pkgs.fetchurl {
            url = "https://cdn.azul.com/zulu/bin/zulu8.58.0.13-ca-jdk8.0.312-linux_x64.tar.gz";
            hash = "sha256-c0F0iPpLf3+MDFlA2r6oeQiymiPh7myUiy8MqLmvIx0=";
          };
        })
        openjdk17
        openjdk21
        openjdk25
      ];
    })
  ];

  xdg.configFile."MangoHud/MangoHud.conf".text = ''
    output_folder=~/.config/MangoHud/logs/
    toggle_hud=Shift_R+F12
    toggle_logging=Shift_L+F12
    toggle_fps_limit=Shift_L+F1
    upload_log=F5
    media_player_name=spotify
    legacy_layout=false

    fps_limit=0,144,60,30

    round_corners=10
    font_size=24
    position=top-left
    table_columns=5

    background_alpha=0.6
    cpu_text=CPU
    gpu_text=GPU

    background_color=1E1E1E
    cpu_color=89B4FA
    cpu_load_color=CDD6F4,FAB387,F38BA8
    engine_color=F38BA8
    fps_color_change=F38BA8,F9E2AF,A6E3A1
    frametime_color=A6E3A1
    gpu_color=A6E3A1
    gpu_load_color=CDD6F4,FAB387,F38BA8
    media_player_color=CDD6F4
    ram_color=F5C2E7
    text_color=CDD6F4
    text_outline_color=313244
    vram_color=F9E2AF
    wine_color=F38BA8

    fps
    cpu_stats
    cpu_temp
    cpu_power
    cpu_mhz
    gpu_stats
    gpu_temp
    gpu_core_clock
    gpu_mem_clock
    gpu_power
    vram
    ram
    frame_timing
  '';
}
