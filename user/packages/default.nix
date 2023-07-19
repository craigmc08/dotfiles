{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Command line tools.
      exa
      fd
      htop
      fzf
      unzip
      zip
      ripgrep
      ffmpeg

      # System managing.
      ncdu
      neofetch

      # Editing.
      nixfmt
      rnix-lsp # nix lsp
      taplo # toml lsp
    ];
  };
}
