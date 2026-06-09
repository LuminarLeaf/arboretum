{
  description = "Leaf's Collection of Trees";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";
    nixpkgs-patch-android-studio-bump = {
      url = "https://github.com/NixOS/nixpkgs/pull/529755.diff";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi-flavours = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };

    adw-catppuccin = {
      url = "github:LuminarLeaf/adw-catppuccin";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    userSettings = {
      username = "leaf";
      name = "Luminar Leaf";
      git_email = "80571430+LuminarLeaf@users.noreply.github.com";
    };
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
      };
    };

    catppuccin-config = {
      catppuccin = {
        enable = true;
        autoEnable = false;
      };
    };

    hm-modules = [
      ./home/home.nix
      inputs.nix-index-database.homeModules.nix-index
      inputs.catppuccin.homeModules.catppuccin
      catppuccin-config
    ];
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations = {
      maple = inputs.nixpkgs-patcher.lib.nixosSystem {
        nixpkgsPatcher.inputs = inputs;

        specialArgs = {
          inherit userSettings;
          inherit inputs;
        };
        modules = [
          ./hosts/maple/configuration.nix
          inputs.catppuccin.nixosModules.catppuccin
          catppuccin-config

          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userSettings.username}.imports = hm-modules;
              backupFileExtension = "backup-hm";

              extraSpecialArgs = {inherit userSettings inputs;};
              verbose = true;
            };
          }
        ];
      };
    };

    homeConfigurations = {
      ${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules =
          hm-modules
          ++ [
            {
              programs.home-manager.enable = true;
            }
          ];
        extraSpecialArgs = {
          inherit userSettings;
          inherit inputs;
        };
      };
    };

    packages.x86_64-linux = {
      nixCats = import ./pkgs/nixCats {
        inherit (inputs) nixCats nixpkgs;
        inherit inputs system;
      };
      tmux-mighty-scroll = pkgs.callPackage ./pkgs/tmux-mighty-scroll {};
      base24-schemes = pkgs.callPackage ./pkgs/base24-schemes {};
    };
  };
}
