# Import as a system configuration module.
{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.niri.nixosModules.niri ];

  programs.niri.enable = true;
  xdg.portal.enable = true;
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];

  services.displayManager.gdm.enable = true;
  services.playerctld.enable = true;

  programs.xfconf.enable = true; # save configuration for XFCE apps
  programs.thunar = { # file manager
    enable = true;
    plugins = [
      pkgs.xfce.thunar-archive-plugin
      pkgs.xfce.thunar-volman
    ];
  };
  services.gvfs.enable = true; # mount, trash, etc. for thunar
  services.tumbler.enable = true; # image thumbnails
}
