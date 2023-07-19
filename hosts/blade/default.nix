{ lib, pkgs, config, inputs, modulesPath, ... }: {
  imports = [
    ../../nixos
    ../../nixos/bootable.nix
    ../../nixos/desktop
  ];
}
