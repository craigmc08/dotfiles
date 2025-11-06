# Import in home-manager configuration.
{ config, pkgs, pkgsUnstable, ... }:

{
  home.packages = [
    pkgs.xwayland-satellite
    pkgs.python314 # required by waybar custom modules
    pkgs.pavucontrol # used by volume waybar module
    pkgs.swaybg
    pkgs.waypaper # Wallpaper settings GUI
    pkgsUnstable.albert # app launcher
  ];

  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/desktop/config.kdl";
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "${config.dotfiles}/desktop/waybar";

  programs.waybar = { enable = true; };

  programs.swaylock = { enable = true; };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
}
