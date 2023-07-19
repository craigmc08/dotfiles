{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.foot;

in {
	options.modules.foot = { enable = mkEnableOption "foot"; };

	config = mkIf cfg.enable {
		programs.foot = {
			enable = true;
			settings = {
				main = {
					font = "FiraCode";
					pad = "8x8";
				};

				colors = {
					foreground = "e5ded6";
					background = "162c23";

					regular0 = "13181e"; # black
					regular1 = "d32c4d"; # red
					regular2 = "57a331"; # green
					regular3 = "dc7759"; # yellow
					regular4 = "36b2d4"; # blue
					regular5 = "b759dc"; # magenta
					regular6 = "23a580"; # cyan
					regular7 = "c6b8ad"; # white

					bright0 = "313f4e";
					bright1 = "dc597f";
					bright2 = "7fdc59";
					bright3 = "dcb659";
					bright4 = "59dcd8";
					bright5 = "dc59c0";
					bright6 = "59dcb7";
					bright7 = "e5ded6";
				};
			};
		};
	};
}
