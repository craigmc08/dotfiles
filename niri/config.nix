{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.xwayland-satellite
    pkgs.python314 # required by waybar custom modules
    pkgs.pavucontrol # used by volume waybar module
  ];

  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/niri/config.kdl";
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/niri/waybar";

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
}
