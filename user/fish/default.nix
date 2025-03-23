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

    programs.autojump = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.fish = {
      enable = true;
      interactiveShellInit = "	set fish_greeting # Disable greeting\n";

      functions = {
        ll = "eza --agl $argv";
        lll = "eza -glT $argv";
      };

      plugins = [
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
            sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
          };
        }
      ];
    };
  };
}
