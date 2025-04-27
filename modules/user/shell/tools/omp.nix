{pkgs, ...}: {
  programs.oh-my-posh = {
    enable = true;
    package = pkgs.oh-my-posh;
    enableZshIntegration = true;
    # useTheme = "catppuccin";
    settings = {
      version = 2;
      disable_notice = true;
      final_space = true;
      # console_title_template = "{{ .Shell }} in {{ .Folder }}";

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
            # nix3 incompatible as it doesn't create the IN_NIX_SHELL env var
            {
              type = "nix-shell";
              style = "plain";
              foreground = "p:nix";
              template = "{{ if ne .Type \"unknown\" }}{{ .Var.sepld }}nix-shell{{ .Var.sepr }}{{ end }}";
              # template = "{{ .Var.sepld }} via {{ .Type }} {{ .Var.sepr }}";
            }
            {
              type = "path";
              style = "plain";
              foreground = "p:text";
              template = "{{ .Var.sepld }}{{ path .Path .Location }}{{ .Var.sepr }}";
              properties.style = "full";
            }
            {
              type = "python";
              style = "plain";
              foreground = "p:py";
              template = "{{ .Var.sepld }} {{ if .Error }}{{ .Error }}{{ else }}{{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }}{{ end }}{{ .Var.sepr }}";
              properties.display_mode = "context";
            }
            {
              type = "node";
              style = "plain";
              foreground = "p:node";
              template = "{{ .Var.sepld }}󰎙 {{if .Error}}{{ .Error }} {{ else }}{{ .Full }}{{ end }}{{ .Var.sepr }}";
            }
            {
              type = "go";
              style = "plain";
              foreground = "p:go";
              template = "{{ .Var.sepld }}󰟓 {{if .Error}}{{ .Error }} {{ else }}{{ .Full }}{{ end }}{{ .Var.sepr }}";
              properties.parse_mod_file = true;
            }
            {
              type = "rust";
              style = "plain";
              foreground = "p:rust";
              template = "{{ .Var.sepld }} {{if .Error}}{{ .Error }} {{ else }}{{ .Full }}{{ end }}{{ .Var.sepr }}";
            }
            {
              type = "git";
              style = "plain";
              foreground = "p:git";
              template = "{{ .Var.sepld }}{{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }}{{ .Var.sepr }}";
              properties.fetch_status = true;
            }
          ];
        }
        {
          type = "prompt";
          alignment = "left";
          newline = true;
          segments = [
            {
              type = "executiontime";
              style = "plain";
              foreground = "p:text";
              template = " {{ .FormattedMs }} ";
              properties.threshold = 500;
            }
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
        foreground_templates = ["{{ if gt .Code 0 }}p:error{{ end }}"];
        foreground = "p:text";
        template = "{{ .PWD }} ❱ ";
      };
      secondary_prompt = {
        foreground = "p:text";
        template = "❱❱ ";
      };
      palette = {
        text = "lightBlue";
        error = "lightRed";
        root = "red";
        separator = "green";
        git = "lightWhite";
        os = "lightMagenta";
        nix = "cyan";
        py = "lightYellow";
        node = "lightGreen";
        go = "lightBlue";
        rust = "lightRed";
      };
    };
  };
}
