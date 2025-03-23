{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.packages;

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Command line tools.
      eza
      fd
      htop
      fzf
      unzip
      zip
      ripgrep
      ffmpeg
      rustup
      meson
      ninja

      # System managing.
      ncdu
      neofetch

      # Editing.
      nixfmt-classic
      nil # nix lsp
      taplo # toml lsp
    ];
  };
}
