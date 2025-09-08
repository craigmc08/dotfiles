{
  description = "A simple system flake using some Aux defaults";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

  outputs =
    inputs@{ nixpkgs, ... }:
    let
      system = "x86_64-linux";
      hostName = "lauma"; # Set this variable equal to your hostName
    in
    {
      nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix

          {
            networking.hostName = hostName;
            nixpkgs.hostPlatform = system;
          }
        ];

        specialArgs = {
          inherit inputs;
        };
      };
    };
}
