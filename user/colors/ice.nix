{ lib, config, ... }:

let colors = {
		  rosewater = "#f5e0dc";
		  flamingo = "#f2cdcd";
		  pink = "#f5c2e7";
		  mauve = "#cba6f7";
		  red = "#f38ba8";
		  maroon = "#eba0ac";
		  peach = "#fab387";
		  yellow = "#f9e2af";
		  green = "#a6e3a1";
		  teal = "#94e2d5";
		  sky = "#89dceb";
		  sapphire = "#74c7ec";
		  blue = "#89b4fa";
		  lavender = "#b4befe";

		  text = "#cdd6f4";
		  subtext1 = "#bac2de";
		  subtext0 = "#a6adc8";
		  overlay2 = "#9399b2";
		  overlay1 = "#7f849c";
		  overlay0 = "#6c7086";

		  surface2 = "#585b70";
		  surface1 = "#45475a";
		  surface0 = "#313244";

		  base = "#1e1e2e";
		  mantle = "#181825";
		  crust = "#11111b";
		};

in {
	config.modules.colors = rec {
		bg = "#1e1e2e";
		bgLight = "#3b3c4e";
		fg = "#cdd6f4";
		fgLight = "#adb6c4";
		accent = colors.mauve;

		bar = {
			workspace = {
				empty = bgLight;
				monitor1 = colors.red;
				monitor2 = colors.peach;
				monitor3 = colors.green;
				monitor4 = colors.blue;

				active1 = colors.mauve;
				active2 = colors.green;
				active3 = colors.sapphire;
			};

			system = {
				brightness = colors.yellow;
				volume = colors.teal;
				bluetooth = colors.sky;
				wifi = colors.rosewater;

				cpu = colors.blue;
				mem = colors.peach;
				battery = colors.green;
				batteryCharging = colors.yellow;
				batteryCritical = colors.red;
			};

			date = colors.flamingo;
		};

		window.border = colors.blue;
		window.shadow = "#00000088";
		window.inactiveBorder = "#999999";

		urgent = colors.red;
		info = bg;
	};
}
