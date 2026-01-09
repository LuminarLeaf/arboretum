{
  description = "Leaf's Collection of Trees";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    # nixCats-nixpkgs.url = "github:NixOS/nixpkgs/0147c2f1d54b30b5dd6d4a8c8542e8d7edf93b5d";

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vuetorrent = {
      url = "github:VueTorrent/VueTorrent/latest-release";
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
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    formatter.${system} = pkgs.alejandra;

    nixosConfigurations = {
      maple = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit userSettings;
          inherit inputs;
        };
        modules = [
          ./hosts/maple/configuration.nix
          inputs.catppuccin.nixosModules.catppuccin
        ];
      };
    };

    homeConfigurations = {
      ${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/home.nix
          inputs.nix-index-database.homeModules.nix-index
          inputs.catppuccin.homeModules.catppuccin
          inputs.spicetify-nix.homeManagerModules.default
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
