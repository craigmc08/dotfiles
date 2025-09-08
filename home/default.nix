{ config, pkgs, ... }:

{
  imports = [
    (import ./helix)
  ];

  home.stateVersion = "25.05";
}
