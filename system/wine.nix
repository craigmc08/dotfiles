{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.wineWow64Packages.full ];
}
