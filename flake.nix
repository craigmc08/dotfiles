{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    NixOS-WSL = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { home-manager, nixpkgs, ... }@inputs:
    let
      specialArgs.inputs = inputs;

      mkSystem = { system, hostname }:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = system;
          modules = [
            { networking.hostName = hostname; }
            (./. + "/hosts/${hostname}/system.nix")
            (./. + "/hosts/${hostname}/hardware-configuration.nix")
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.craig = (./. + "/hosts/${hostname}/user.nix");
              };
            }
          ];
        };
    in {
      nixosConfigurations = {
        kafka = mkSystem {
          system = "x86_64-linux";
          hostname = "kafka";
        };

        blade = mkSystem {
          system = "x86_64-linux";
          hostname = "blade";
        };
      };
    };
}
