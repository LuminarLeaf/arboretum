{
  description = "Leaf's Collection of Trees";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.05";

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {self, ...} @ inputs: let
    userSettings = {
      username = "leaf";
      name = "Luminar Leaf";
      git_email = "80571430+LuminarLeaf@users.noreply.github.com";
    };
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs-stable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    formatter.${system} = inputs.alejandra.defaultPackage.${system};

    nixosConfigurations = {
      maple = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit pkgs pkgs-stable;
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
          inputs.catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = {
          inherit pkgs-stable;
          inherit userSettings;
          inherit inputs;
        };
      };
    };
  };
}
