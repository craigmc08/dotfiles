{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.colors;
		color = (import ../lib/color.nix) { inherit lib; };
		inherit (color.types) hexColor;

in {
	options.modules.colors = {
		# Common colors
		bg = mkOption { type = hexColor; description = "Background color for UI elements."; };
		bgLight = mkOption { type = hexColor; description = "Background color to use a nested group of elements."; };
		fg = mkOption { type = hexColor; description = "Foreground color."; };
		fgLight = mkOption { type = hexColor; description = "Lightened foreground color."; };
		accent = mkOption { type = hexColor; description = "Accented foreground color."; };

		text = mkOption {
			type = hexColor;
			description = "Default text color";
			defaultText = "config.modules.colors.fg";
			default = cfg.fg;
		};
		subtext = mkOption {
			type = hexColor;
			description = "Lighter text color";
			defaultText = "config.modules.colors.fgLight";
			default = cfg.fgLight;
		};

		# eww bar/window colors.
		bar = {
			workspace = {
				empty = mkOption {
					type = hexColor;
					description = "Color of workspace indicator with no windows.";
					defaultText = "config.modules.colors.bgLight";
					default = cfg.bgLight;
				};
				monitor1 = mkOption { type = hexColor; description = "Color of workspace that is displayed on monitor 1"; };
				monitor2 = mkOption { type = hexColor; description = "Color of workspace that is displayed on monitor 2"; };
				monitor3 = mkOption { type = hexColor; description = "Color of workspace that is displayed on monitor 3"; };
				monitor4 = mkOption { type = hexColor; description = "Color of workspace that is displayed on monitor 4"; };

				active1 = mkOption { type = hexColor; description = "Color 1 for active workspace animation"; };
				active2 = mkOption { type = hexColor; description = "Color 2 for active workspace animation"; };
				active3 = mkOption { type = hexColor; description = "Color 3 for active workspace animation"; };
			};

			system = {
				brightness = mkOption { type = hexColor; description = "Color of brightness-related elements."; };
				volume = mkOption { type = hexColor; description = "Color of volume-related elements."; };
				bluetooth = mkOption { type = hexColor; description = "Color of bluetooth-related elements."; };
				wifi = mkOption { type = hexColor; description = "Color of wifi-related elements."; };

				cpu = mkOption { type = hexColor; description = "Color of CPU-related elements."; };
				mem = mkOption { type = hexColor; description = "Color of memory-related elements."; };
				battery = mkOption { type = hexColor; description = "Color of battery-related elements."; };
				batteryCharging = mkOption { type = hexColor; description = "Color of battery elements when plugged in."; };
				batteryCritical = mkOption {
					type = hexColor;
					description = "Color of battery elements when charge is low.";
					defaultText = "config.modules.color.urgent";
					default = cfg.urgent;
				};
			};

			clock = mkOption {
				type = hexColor;
				description = "Color of system clock.";
				defaultText = "config.modules.colors.text";
				default = cfg.text;
			};
			date = mkOption { type = hexColor; description = "Color of date (and day names in calendar)."; };
		};

		window = {
			border = mkOption { type = hexColor; description = "Color of active window border."; };
			shadow = mkOption { type = hexColor; description = "Color of active window shadow."; };
			inactiveBorder = mkOption { type = hexColor; description = "Color of inactive window borders."; };
		};

		urgent = mkOption { type = hexColor; description = "Color to use for urgent elements (like notifications)."; };
		info = mkOption { type = hexColor; description =" Color for information elements (like notifications)."; };
	};
}
