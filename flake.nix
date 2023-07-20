{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    eww = {
      url = "github:fufexan/eww/globalstyle";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    gross = {
      url = "github:fufexan/gross";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
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

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://fufexan.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "fufexan.cachix.org-1:LwCDjCJNJQf5XD2BV+yamQIMZfcKWR9ISIFy5curUsY="
    ];
  };
}
