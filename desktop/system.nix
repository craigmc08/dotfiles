# Import as a system configuration module.
{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.niri.nixosModules.niri ];

  programs.niri.enable = true;
  xdg.portal.enable = true;
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];

  services.xserver.displayManager.gdm.enable = true;
  services.playerctld.enable = true;
}
