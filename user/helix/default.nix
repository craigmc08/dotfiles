{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.helix;

in {
  options.modules.helix = { enable = mkEnableOption "helix"; };

  config = mkIf cfg.enable {
    home.sessionVariables = { EDITOR = "hx"; };

    programs.helix = {
      enable = true;

      settings = {
        theme = "bogster";
        editor = {
          cursorline = true;
          completion-trigger-len = 1;
          idle-timeout = 50;
          mouse = false;
          rulers = [ 81 121 ];
          true-color = true;
          color-modes = true;
        };
        editor.statusline = {
          mode.normal = " ";
          mode.insert = "i";
          mode.select = "s";
        };
        editor.lsp.display-messages = true;
        editor.cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        editor.indent-guides = {
          render = true;
          character = "┆";
        };
      };

      languages = {
        language = [
          {
            name = "haskell";
            auto-format = true;
            indent = {
              tab-width = 2;
              unit = "  ";
            };
          }
          {
            name = "python";
            auto-format = true;
            indent = {
              tab-width = 4;
              unit = "    ";
            };
          }
          {
            name = "rust";
            auto-format = true;
            indent = {
              tab-width = 2;
              unit = "  ";
            };
          }
        ];
      };
    };
  };
}
