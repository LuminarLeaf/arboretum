{...}: {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    general.live_config_reload = true;
    # env.TERM = "xterm-256color";
    window = {
      padding = {
        x = 5;
        y = 5;
      };
      dynamic_padding = true;
      opacity = 0.9;
      blur = true;
      title = "Alacritty";
      resize_increments = true;
    };

    font = {
      normal = {
        family = "MonaspiceNe Nerd Font";
        style = "Regular";
      };
      size = 12;
    };

    cursor = {
      style = {
        shape = "Beam";
        blinking = "On";
      };
      vi_mode_style = {
        shape = "Underline";
      };
    };

    mouse = {
      hide_when_typing = true;
      bindings = [
        {
          mouse = "Middle";
          action = "PasteSelection";
        }
      ];
    };

    keyboard = {
      bindings = [
        {
          key = "Return";
          mods = "Control|Shift";
          action = "SpawnNewInstance";
        }
        {
          key = "W";
          mods = "Control|Shift";
          action = "Quit";
        }
      ];
    };
  };
  programs.alacritty.catppuccin.enable = true;
}
