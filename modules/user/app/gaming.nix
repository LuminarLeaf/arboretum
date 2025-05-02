{pkgs, ...}: {
  home.packages = with pkgs; [
    (prismlauncher.override {
      jdks = [
        openjdk8
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

    background_alpha=0.4
    cpu_text=CPU
    gpu_text=GPU

    background_color=1E1E1E
    cpu_color=89DCEB
    engine_color=F38BA8
    frametime_color=A6E3A1
    gpu_color=CBA6F7
    media_player_color=CDD6F4
    ram_color=FAB387
    text_color=CDD6F4
    text_outline_color=313244
    vram_color=F9E2AF
    wine_color=B4BEFE

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
    frame_timing=1
  '';
}
