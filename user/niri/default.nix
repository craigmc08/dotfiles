# Programs needed for niri. Does not install niri. Oops.
{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.niri;

in {
  options.modules.niri = { enable = mkEnableOption "niri"; };

  config = mkIf cfg.enable {
    programs.fuzzel.enable = true;
    programs.fuzzel.settings = {
      main = {
        line-height = 20;
      };

      colors = {
        background = "1E1E2EEE";
        text = "CDD6F4FF";
        match = "F38BA8FF";
        selection = "313244EE";
        selection-text = "F38BA8FF";
        border = "74C7ECFF";
      };

      border = {
        width = 4;
        radius = 16;
      };
    };

    xdg.configFile."niri/config.kdl" = {
      enable = true;
      source = ./config.kdl;
    };
    xdg.configFile."waybar/config" = {
      enable = true;
      source = ./waybar/config;
    };
    xdg.configFile."waybar/style.css" = {
      enable = true;
      source = ./waybar/style.css;
    };
  };
}
