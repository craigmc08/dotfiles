{ lib, pkgs, config, inputs, ... }: {
  imports = [ ./shell.nix ];

  home.stateVersion = "23.05";

  home.packages = [
    pkgs.exa
    pkgs.fd
    pkgs.htop
    pkgs.fzf

    # Haskell
    pkgs.haskellPackages.cabal-install
    pkgs.haskellPackages.haskell-language-server

    pkgs.ncdu
    pkgs.neofetch
    pkgs.nixfmt

    # Javascript
    pkgs.nodejs_18
    pkgs.nodePackages.bash-language-server
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.vscode-json-languageserver-bin

    pkgs.rnix-lsp # nix lsp
    pkgs.taplo # toml lsp
    pkgs.unzip
    pkgs.zip
  ];

  programs.git = {
    enable = true;
    userName = "Craig McIlwrath";
    userEmail = lib.mkDefault "craigmc08@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  programs.helix = {
    enable = true;
    package = pkgs.unstable.helix;
    settings = {
      theme = "bogster";
      editor = {
        cursorline = true;
        completion-trigger-len = 1;
        idle-timeout = 50;
        mouse = false;
        rulers = [81 121];
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
          indent = { tab-width = 2; unit = "  "; };
        }
        {
          name = "python";
          auto-format = true;
          indent = { tab-width = 4; unit = "    "; };
        }
        {
          name = "rust";
          auto-format = true;
          indent = { tab-width = 2; unit = "  "; };
        }
      ];
    };
  };
}

  
