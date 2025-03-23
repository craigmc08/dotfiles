{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.jj;

in {
  options.modules.jj = { enable = mkEnableOption "jj"; };

  config = mkIf cfg.enable {
    programs.jujutsu = {
      enable = true;
      settings = {
        ui = {
          default-command = ["log"];
          editor = if config.modules.helix.enable then "hx" else "vi";
        };
        user = {
          name = "Crag McIlwrath";
          email = "craigmc08@gmail.com";
        };
      };
    };
  };
}
