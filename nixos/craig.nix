{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.craig = { pkgs, ... }: {
        imports = [ ../home inputs.vscode-server.nixosModules.home ];
        home.stateVersion = "23.05";
        services.vscode-server.enable = true;
      };
    };

    users.users.craig = {
      isNormalUser = true;
      description = "Craig McIlwrath";
      extraGroups = lib.mkDefault [ "wheel" ];
    };
  };
}
