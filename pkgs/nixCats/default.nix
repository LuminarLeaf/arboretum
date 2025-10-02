{
  nixCats,
  nixpkgs,
  system,
  ...
}: let
  inherit (nixCats) utils;
  luaPath = "${./.}";
  extra_pkg_config = {};

  dependencyOverlays = [];
  categoryDefinitions = {
    pkgs,
    settings,
    categories,
    extra,
    name,
    mkPlugin,
    ...
  } @ packageDef: {
    lspsAndRuntimeDeps = with pkgs; {
      general = [
        curl
        fd
        ripgrep
        stdenv.cc.cc
        universal-ctags

        (pkgs.writeShellScriptBin "lazygit" ''
          exec ${pkgs.lazygit}/bin/lazygit --use-config-file ${pkgs.writeText "lazygit_config.yml" ""} "$@"
        '')

        alejandra
        bacon
        bash-language-server
        biome
        black
        clang-tools
        delve
        docker-compose-language-service
        dockerfile-language-server
        emmet-language-server
        gofumpt
        gopls
        gotools
        lua-language-server
        markdownlint-cli2
        marksman
        nixd
        nodePackages.prettier
        pyright
        ruff
        rust-analyzer
        shellcheck
        shfmt
        sqls
        statix
        stylua
        taplo
        texlab
        typescript-language-server
        vale
        vscode-js-debug
        vscode-langservers-extracted
        vtsls
        yaml-language-server
      ];
    };

    startupPlugins = {};

    optionalPlugins = with pkgs.vimPlugins; {
      general = [
        lazy-nvim
        LazyVim

        blink-cmp
        bufferline-nvim
        clangd_extensions-nvim
        conform-nvim
        copilot-lua
        CopilotChat-nvim
        flash-nvim
        friendly-snippets
        gitsigns-nvim
        grug-far-nvim
        lazydev-nvim
        lualine-nvim
        markdown-preview-nvim
        mini-ai
        mini-hipatterns
        mini-icons
        mini-pairs
        neo-tree-nvim
        noice-nvim
        nui-nvim
        nvim-dap
        nvim-dap-go
        nvim-dap-python
        nvim-dap-ui
        nvim-dap-virtual-text
        nvim-lint
        nvim-lspconfig
        nvim-nio
        nvim-treesitter-context
        nvim-treesitter-textobjects
        nvim-treesitter.withAllGrammars
        nvim-ts-autotag
        nvim-web-devicons
        persistence-nvim
        plenary-nvim
        render-markdown-nvim
        SchemaStore-nvim
        snacks-nvim
        telescope-fzf-native-nvim
        telescope-nvim
        todo-comments-nvim
        tokyonight-nvim
        trouble-nvim
        ts-comments-nvim
        vim-illuminate
        vim-startuptime
        vimtex
        which-key-nvim
        yanky-nvim

        (pkgs.vimUtils.buildVimPlugin {
          pname = "venv-selector.nvim";
          version = "2025-09-19";
          # TODO: either npins or flake input
          src = pkgs.fetchFromGitHub {
            owner = "linux-cultist";
            repo = "venv-selector.nvim";
            rev = "2b49d1f8b8fcf5cfbd0913136f48f118225cca5d";
            sha256 = "sha256-mz9RT1foan2DCHTZppuPZHaEqREqOHg2WU7uk3bjl0E=";
          };
          meta.homepage = "https://github.com/linux-cultist/venv-selector.nvim";
        })
        {
          plugin = catppuccin-nvim;
          name = "catppuccin";
        }
        {
          plugin = harpoon2;
          name = "harpoon";
        }
      ];
    };
  };

  packageDefinitions.nvim = {
    pkgs,
    name,
    mkPlugin,
    ...
  }: {
    settings = {
      suffix-path = true;
      suffix-LD = true;
      wrapRc = true;
      # aliases = ["vim"];
      hosts.python3.enable = true;
      hosts.node.enable = true;
    };
    categories = {
      general = true;
    };
    extra = {};
  };
in
  utils.baseBuilder luaPath {
    inherit nixpkgs system dependencyOverlays extra_pkg_config;
  }
  categoryDefinitions
  packageDefinitions
  "nvim"
