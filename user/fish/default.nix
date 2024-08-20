{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.fish;

in {
  options.modules.fish = { enable = mkEnableOption "fish"; };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      # exa
      TIME_STYLE = "iso";
    };

    programs.starship = { enable = true; };

    programs.fish = {
      enable = true;
      interactiveShellInit = "	set fish_greeting # Disable greeting\n";

      functions = {
        ll = "eza --agl $argv";
        lll = "eza -glT $argv";
      };
    };
  };
}
