{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.minecraft;

in {
  options.modules.aseprite = { enable = mkEnableOption "aseprite"; };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.aseprite ];
  };
}

