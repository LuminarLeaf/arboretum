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

        bacon
        bash-language-server
        biome
        black
        clang-tools
        delve
        docker-compose-language-service
        dockerfile-language-server-nodejs
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
        CopilotChat-nvim
        flash-nvim
        friendly-snippets
        gitsigns-nvim
        grug-far-nvim
        lazydev-nvim
        lualine-nvim
        markdown-preview-nvim
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

        {
          plugin = catppuccin-nvim;
          name = "catppuccin";
        }
        {
          plugin = harpoon2;
          name = "harpoon";
        }
        {
          plugin = mini-ai;
          name = "mini.ai";
        }
        {
          plugin = mini-hipatterns;
          name = "mini.hipatterns";
        }
        {
          plugin = mini-icons;
          name = "mini.icons";
        }
        {
          plugin = mini-pairs;
          name = "mini.pairs";
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
