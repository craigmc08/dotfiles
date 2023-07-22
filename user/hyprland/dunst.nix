{ lib, pkgs, config, ... }: {
	config = {
		home.packages = [ pkgs.dunst ];

		services.dunst = {
			enable = true;
			settings = {
				global = {
					alignment = "left";
					corner-radius = 16;
					format = "<b>%s</b>\\n%b";
					frame_width = 0;
					offset = "20x20";
					origin = "bottom-right";
					horizontal_padding = 10;
					padding = 5;
					icon_position = "left";
					indicate_hidden = "yes";
					markup = "yes";
					max_icon_size = 64;
					mouse_left_click = "do_action";
					mouse_right_click = "close_current";
					plain_text = "no";
					separator_color = "auto";
					separator_height = 1;
					show_indicators = true;
					word_wrap = "yes";
				};

				fullscreen_delay_everything = { fullscreen = "delay"; };

				# TODO: colors for urgency_critical,normal,low to make it fit with
				# theme. do this after i figure out how im gonna do colors for everything...
				# https://dunst-project.org/documentation/#Urgency-sections
			};
		};
	};
}
