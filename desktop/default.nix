# Import in home-manager configuration.
{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.xwayland-satellite
    pkgs.python314 # required by waybar custom modules
    pkgs.pavucontrol # used by volume waybar module
    pkgs.swaybg
    pkgs.waypaper # Wallpaper settings GUI
  ];

  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/desktop/config.kdl";
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/desktop/waybar";

  programs.waybar = { enable = true; };

  programs.fuzzel = {
    enable = true;
    settings = {
      border = {
        radius = 4;
        width = 2;
      };
    };
  };

  programs.swaylock = { enable = true; };
}
