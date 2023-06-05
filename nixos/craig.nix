{ config, lib, pkgs, inputs, ... }:

{
  imports = [inputs.home-manager.nixosModules.home-manager ];

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.craig = { pkgs, ... }: {
        imports = [ ../home ];
        home.stateVersion = "22.11";
      };
    };

    users.users.craig = {
      isNormalUser = true;
      description = "Craig McIlwrath";
      extraGroups = lib.mkDefault [ "wheel" ];
    };
  };
}
