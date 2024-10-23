{pkgs-unstable, ...}: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs-unstable.oh-my-posh;
    enableZshIntegration = true;
    # useTheme = "catppuccin";
    settings = {
      version = 2;
      disable_notice = true;
      final_space = true;
      console_title_template = "{{ .Shell }} in {{ .Folder }}";

      var = {
        sepl = "<p:separator>❬</>";
        sepld = "<p:separator>-❬</>";
        sepr = "<p:separator>❭</>";
      };

      blocks = [
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "root";
              style = "plain";
              foreground = "p:root";
              template = " ";
            }
            {
              type = "os";
              style = "plain";
              foreground = "p:os";
              template = "{{ .Var.sepl }}{{ .UserName }}{{ .Icon }} {{ .HostName }}{{ .Var.sepr }}";
            }
            {
              type = "path";
              style = "plain";
              foreground = "p:text";
              template = "{{ .Var.sepld }}{{ .Path }}{{ .Var.sepr }}";
              properties.style = "full";
            }
            {
              type = "python";
              style = "plain";
              foreground = "p:py";
              template = "{{ .Var.sepld }} {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }}{{ end }}{{ end }}{{ .Var.sepr }}";
              properties = {
                display_mode = "context";
                fetch_virtual_env = true;
                display_default = true;
              };
            }
            {
              type = "node";
              style = "plain";
              foreground = "p:node";
              template = "{{ .Var.sepld }}󰎙 {{if .Error}}{{ .Error }} {{ else }}{{ .Major }}{{ end }}{{ .Var.sepr }}";
              properties.display_mode = "context";
            }
            {
              type = "git";
              style = "plain";
              foreground = "p:git";
              template = "{{ .Var.sepld }}{{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }}{{ .Var.sepr }}";
              properties.display_mode = "context";
            }
          ];
        }
        {
          type = "prompt";
          alignment = "right";
          overflow = "hide";
          segments = [
            {
              type = "executiontime";
              style = "plain";
              foreground = "p:text";
              template = "{{ .Var.sepl }}{{ .FormattedMs }}{{ .Var.sepr }}";
              properties.threshold = 500;
            }
          ];
        }
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "text";
              style = "plain";
              foreground_templates = [
                "{{ if gt .Code 0 }}p:error{{ end }}"
                "p:text"
              ];
              template = "❱";
            }
          ];
        }
      ];
      transient_prompt = {
        foreground_templates = [
          "{{ if gt .Code 0 }}p:error{{ end }}"
          "p:text"
        ];
        template = "❱ ";
      };
      secondary_prompt = {
        foreground = "p:text";
        template = "❱❱";
      };
      palette = {
        text = "lightBlue";
        error = "lightRed";
        root = "red";
        separator = "green";
        py = "lightYellow";
        node = "lightGreen";
        git = "lightWhite";
        os = "lightMagenta";
      };
    };
  };
}
