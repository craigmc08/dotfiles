{ config, pkgs, options, lib, ... }:

{
  options = {
    dotfiles = lib.mkOption {
      type = lib.types.path;
      apply = toString;
      default = "${config.home.homeDirectory}/dotfiles";
      example = "${config.home.homeDirectory}/dotfiles";
      description = "Location of this dotfiles repo in the system";
    };
  };

  imports = [ ./helix ./alacritty ./spicetify ./firefox ./games ];

  config = {
    home.stateVersion = "25.05";

    home.packages = [
      # cli tools
      pkgs.eza
      pkgs.unzip
      pkgs.zip
      pkgs.ripgrep
      pkgs.ffmpeg

      # configuration tools
      pkgs.overskride # bluetooth manager

      # system management
      pkgs.htop
      pkgs.neofetch
      pkgs.ncdu
      pkgs.dnsutils

      # Language servers and formatters
      pkgs.nixfmt
      pkgs.nil # Nix language server
      pkgs.taplo # TOML language server

      pkgs.discord
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        "l" = "eza";
        "ls" = "eza";
        "tree" = "eza -T";

        "jjd" = "jj --diff --from 'trunk()'";
        "jjtop" = "jj new 'trunk()'";
        "jjf" = "jj git fetch";
        "jjp" = "jj git push";
        "jjsq" = "jj squash --keep-emptied";
      };
      initContent = ''
        jjn() {
          new=$(jj new -B @ --no-edit 2>&1 | grep 'Created new' | cut '-d ' -f 4)
          jj describe -r "$new" $@
        }

        t() {
          pushd $(mktemp -d "/tmp/$1.XXXX")
        }

        source <(COMPLETE=zsh jj)
      '';
      history.size = 1000000;
    };
    programs.autojump = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.git = {
      enable = true;
      userName = "Craig McIlwath";
      userEmail = "craigmc08@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
      };
      ignores = [ ".env" "__scripts" ];
    };
    programs.jujutsu = {
      enable = true;
      settings = {
        ui = {
          default-command = ["log"];
          editor = "hx";
        };
        user = {
          name = "Craig McIlwrath";
          email = "craigmc08@gmail.com";
        };
      };
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
