{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";

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
      url = "github:nix-community/home-manager/master";
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

    spicetify-nix.url = "github:the-argus/spicetify-nix";

    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = { self, home-manager, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      mkHome = hostname: {
        "craig@${hostname}" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [ inputs.nixgl.overlay ];
          };
          extraSpecialArgs = { inherit inputs outputs; };

          modules = [ (./. + "/hosts/${hostname}/user.nix") ];
        };
      }; 

   in {
      defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;

      homeConfigurations = mkHome "firefly" // mkHome "kafka";
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
