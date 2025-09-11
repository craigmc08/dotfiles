{
  description = "A simple system flake using some Aux defaults";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  inputs.home-manager = {
    url = "github:nix-community/home-manager/release-25.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.spicetify-nix = {
    url = "github:Gerg-L/spicetify-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.niri = {
    url = "github:sodiboo/niri-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
    let
      specialArgs = { inherit inputs; };
      mkSystem = { system, hostName }:
        nixpkgs.lib.nixosSystem {
          modules = [
            {
              networking.hostName = hostName;
              nixpkgs.hostPlatform = system;
            }
            ./host/${hostName}/hardware-configuration.nix
            ./host/${hostName}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.users.craig = import ./host/${hostName}/home.nix;
            }
          ];

          specialArgs = specialArgs;
        };
    in {
      nixosConfigurations = {
        lauma = mkSystem {
          system = "x86_64-linux";
          hostName = "lauma";
        };
      };
    };
}
