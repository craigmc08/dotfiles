{ config, pkgs, ... }:

{
  home.packages = [ pkgs.xwayland-satellite pkgs.fuzzel ];

  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/niri/config.kdl";
}
