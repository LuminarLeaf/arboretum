{
  pkgs,
  config,
  lib,
  ...
}: {
  # yanked from iynaix's dotfiles
  config = lib.mkMerge [
    # general settings
    {
      programs.mpv = {
        enable = true;
        config = {
          # https://iamscum.wordpress.com/guides/videoplayback-guide/mpv-conf

          save-position-on-quit = true;
          resume-playback-check-mtime = true;
          force-seekable = true;
          cursor-autohide = 1000;
          keep-open = true;
          volume-max = 150;

          auto-window-resize = false;
          snap-window = true;
          osd-font = "Monaspace Neon";

          autocreate-playlist = "same";
          directory-mode = "auto";

          profile = "high-quality";
          vo = "gpu-next";
          hwdec-codecs = "all";

          demuxer-mkv-subtitle-preroll = true;
          sub-auto = "fuzzy";

          # Debanding: Turned on via keymap
          deband-grain = 0;
          deband-range = 12;
          deband-threshold = 32;
          deband-iterations = 4;

          dither-depth = "auto";
          dither = "fruit";

          screenshot-directory = "${config.xdg.userDirs.pictures}/Screenshots";
          screenshot-high-bit-depth = true;
          screenshot-format = "png";
          screenshot-template = "mpvCapture %tY-%tM-%td %tH%tM%tS";

          # alang = "ja,jp,jpn,en,eng,de,deu,ger";
          # slang = "en,eng,de,deu,ger";
        };
        bindings = {
          "[" = "add speed -0.1";
          "]" = "add speed 0.1";

          "'" = "seek 85";
          ";" = "seek -85";

          # disable annoying defaults
          "1" = "ignore";
          "2" = "ignore";
          "3" = "ignore";
          "4" = "ignore";
          "5" = "ignore";
          "6" = "ignore";
          "7" = "ignore";
          "8" = "ignore";
          "9" = "ignore";
          "0" = "ignore";
          "/" = "ignore";
          "*" = "ignore";
          "Alt+left" = "ignore";
          "Alt+right" = "ignore";
          "Alt+up" = "ignore";
          "Alt+down" = "ignore";
        };
        scripts = with pkgs.mpvScripts; [
          dynamic-crop
          quack
          mpris
        ];
      };

      /*
      wayland.windowmanager.hyprland.settings.windowrulev2 = [
        # do not idle while watching videos
        "idleinhibit focus,class:(mpv)"
        # fix mpv-dynamic-crop unmaximizing the window
        "suppressevent maximize,class:(mpv)"
      ];
      */
    }

    # uosc
    {
      programs.mpv = {
        scripts = with pkgs; [
          mpvScripts.uosc
          mpvScripts.memo
          mpvScripts.thumbfast
        ];
        config = {
          osd-bar = false;
          # border = false;
        };
        bindings = {
          MBTN_MID = "cycle pause";
          MBTN_RIGHT = "script-binding uosc/menu";
          MBTN_FORWARD = "script-binding uosc/prev";
          MBTN_BACK = "script-binding uosc/next";

          WHEEL_UP = "no-osd add volume 2; script-binding uosc/flash-volume";
          WHEEL_DOWN = "no-osd add volume -2; script-binding uosc/flash-volume";
          VOLUME_UP = "no-osd add volume 2; script-binding uosc/flash-volume";
          VOLUME_DOWN = "no-osd add volume -2; script-binding uosc/flash-volume";
          KP_ADD = "no-osd add volume 2; script-binding uosc/flash-volume";
          KP_SUBTRACT = "no-osd add volume -2; script-binding uosc/flash-volume";

          TAB = "script-binding uosc/toggle-ui";

          MENU = "script-binding uosc/menu";
          NEXT = "script-binding uosc/next";
          PREV = "script-binding uosc/prev";

          p = "script-binding uosc/flash-timeline";
          "CTRL+c" = "script-binding uosc/copy-to-clipboard";
        };
        scriptOpts = {
          uosc = {
            timeline_size = 20;
            scale_fullscreen = 1.2;
            border_radius = 8;
          };
        };
        extraInput = ''
          #           script-binding memo-history                                     #! Recents
          o           script-binding uosc/open-file                                   #! Open
          SHIFT+ENTER script-binding uosc/playlist                                    #! Playlist
          ALT+c       script-binding uosc/chapters                                    #! Chapters
          ALT+s       script-binding uosc/subtitles                                   #! Subtitles
          #           script-binding uosc/audio                                       #! Audio
          #           script-binding uosc/audio-device                                #! Utils > Audio devices
          #           set hwdec no                                                    #! Utils > Hardware decoding > Disabled
          #           set hwdec auto-safe                                             #! Utils > Hardware decoding > Enabled
          #           set hwdec auto-copy-safe                                        #! Utils > Hardware decoding > Copyback
          #           set interpolation no                                            #! Utils > Motion interpolation > Disabled
          #           set interpolation yes                                           #! Utils > Motion interpolation > Enabled
          #           set video-aspect-override     -1                                #! Utils > Aspect ratio > Disabled
          #           set video-aspect-override    4:3                                #! Utils > Aspect ratio > 4:3
          #           set video-aspect-override   16:9                                #! Utils > Aspect ratio > 16:9
          #           set video-aspect-override 2.35:1                                #! Utils > Aspect ratio > 2.35:1
          #           set video-rotate   0                                            #! Utils > Rotate > Disabled
          #           set video-rotate  90                                            #! Utils > Rotate > 90°
          #           set video-rotate 180                                            #! Utils > Rotate > 180°
          #           set video-rotate 270                                            #! Utils > Rotate > 270°
          #           set loop-file  no; set loop-playlist  no                        #! Utils > Loop > Disabled
          #           set loop-file inf; set loop-playlist  no                        #! Utils > Loop > Single
          #           set loop-file  no; set loop-playlist inf                        #! Utils > Loop > Playlist
          #           async screenshot video                                          #! Utils > Screenshot
          #           script-binding uosc/show-in-directory                           #! Utils > Show in directory
        '';
      };
    }

    # mpvScripts.occivink.crop if i ever get around to it
  ];
}
