{
  description = "Leaf's Collection of Trees";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixCats.url = "github:BirdeeHub/nixCats-nvim";

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
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
    formatter.${system} = inputs.alejandra.defaultPackage.${system};

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
          inputs.catppuccin.homeModules.catppuccin
          inputs.spicetify-nix.homeManagerModules.default
        ];
        extraSpecialArgs = {
          inherit userSettings;
          inherit inputs;
        };
      };
    };

    packages.x86_64-linux.nixCats = import ./pkgs/nixCats {
      inherit inputs nixpkgs system;
      nixCats = inputs.nixCats;
    };
  };
}
