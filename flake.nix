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

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      hostName = "lauma"; # Set this variable equal to your hostName
    in
    {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          # ./x11
          ./niri

          {
            networking.hostName = hostName;
            nixpkgs.hostPlatform = system;
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.craig = import ./home;
          }
        ];

        specialArgs = {
          inherit inputs;
        };
      };
    };
}
