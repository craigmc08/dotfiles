{ inputs, pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.xdg;

in {
  options.modules.xdg = { enable = mkEnableOption "xdg"; };

  config = mkIf cfg.enable {
    xdg.userDirs = {
      enable = true;
      documents = "$HOME/files/documents/";
      download = "$HOME/download/";
      videos = "$HOME/files/videos/";
      pictures = "$HOME/files/pictures/";
      desktop = "$HOME/desktop/";
      publicShare = "$HOME/files/.other/";
      templates = "$HOME/files/.other/";
    };
  };
}
