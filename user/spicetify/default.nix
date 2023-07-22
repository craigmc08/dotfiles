{ lib, pkgs, config, inputs, ... }:

with lib;
let cfg = config.modules.spicetify;
		spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;

in {
	imports = [ inputs.spicetify-nix.homeManagerModule ];

	options.modules.spicetify = { enable = mkEnableOption "spicetify"; };

	config = mkIf cfg.enable {
		programs.spicetify = {
			enable = true;
			theme = spicePkgs.themes.catppuccin-mocha;
			colorScheme = "flamingo";

			enabledExtensions = with spicePkgs.extensions; [
				fullAppDisplay
				shuffle
				hidePodcasts
			];
		};
	};
}
