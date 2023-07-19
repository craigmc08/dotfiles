{ lib, pkgs, config, inputs, ... }: {
  imports = [
    ./git.nix
    ./helix.nix
    ./shell.nix
  ];

  home.stateVersion = "23.05";

  home.packages = [
    pkgs.exa
    pkgs.fd
    pkgs.htop
    pkgs.fzf

    pkgs.ncdu
    pkgs.neofetch
    pkgs.nixfmt

    pkgs.rnix-lsp # nix lsp
    pkgs.taplo # toml lsp

    pkgs.unzip
    pkgs.zip
  ];
}

  
