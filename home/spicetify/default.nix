{ config, pkgs, inputs, ... }:

let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";

    enabledExtensions = [
      spicePkgs.extensions.fullAppDisplay
      spicePkgs.extensions.shuffle
      spicePkgs.extensions.hidePodcasts
    ];
  };
}
