{ config, pkgs, ... }:

{
  imports = [
    ../../system/configuration.nix
    ../../desktop/system.nix
  ];
}
