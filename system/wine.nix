{ config, pkgsUnstable, pkgs, ... }:

{
  environment.systemPackages = [ pkgsUnstable.wineWow64Packages.stagingFull pkgsUnstable.winetricks ];
}
