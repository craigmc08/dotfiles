{ lib, config, ... }: {
	settings = { mainBar = {
		layer = "bottom";
		position = "top";
		height = 50;
		spacing = 5;
		margin-bottom = -11;
		modules-left = [ "wlr/workspaces" ];
		modules-right = [ "tray" "temperature" "network" "battery" "clock" ];
		# modules-center = [ "custom/dynamic_pill" ];

		# Modules configuration
		"custom/dynamic_pill" = {
			return-type = "json";
			exec = "~/.config/hypr/scripts/tools/start_dyn";
			escape = true;
		};

		keyboard-state = {
			numlock = true;
			capslock = true;
			format = "{name} {icon}";
			format-icons = {
				locked = "";
				unlocked ="";
			};
		};

		"wlr/workspaces" = {
			format = "{icon}";
			format-active = " {icon} ";
			on-click = "active";
		};

		mpd = {
			format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime =%M =%S}/{totalTime =%M =%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
      format-disconnected = "Disconnected ";
      format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
      unknown-tag = "N/A";
      interval = 2;
      consume-icons = {
          on = " ";
      };
      random-icons = {
          off = "<span color=\"#f53c3c\"></span> ";
          on = " ";
      };
      repeat-icons = {
          on = " ";
      };
      single-icons = {
          on = "1 ";
      };
      state-icons = {
          paused = "";
          playing = "";
      };
      tooltip-format = "MPD (connected)";
      tooltip-format-disconnected = "MPD (disconnected)";
		};

		tray = {
			spacing = 10;
		};

		clock = {
			tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
			interval = 60;
			format = "{:%I:%M}";
			max-length = 25;
		};
		cpu = {
			interval = 1;
			format = "{icon0} {icon1} {icon2} {icon3} {icon4}";
			format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
		};
		temperature = {
			critical-threshold = 80;
			format-critical = "{temperatureC}°C";
			format = "";
		};
		battery = {
			states = {
          warning = 50;
          critical = 20;
      };
      format = "{icon}";
      format-charging = "";
      format-plugged = "";
      # "format-good" = "";
      # "format-full" = "";
      format-icons = ["" "" "" "" ""];
		};
		network = {
			format-wifi = "";
			format-ethernet = "";
			tooltip-format = "via {gwaddr} {ifname}";
			format-linked = "";
			format-disconnected = "wifi";
			format-alt = "  ";
		};
	}; };

	style = with config.style; ''
		* {
			font-family: FiraCode Nerd Font Mono;
			font-size: 13px;
		}

		window#waybar {
			background-color: transparent;
		}

		#workspaces {
			background-color: transparent;
			margin-top: 10px;
			margin-bottom: 10px;
			margin-right: 10px;
			margin-left: 25px;
		}
		#workspaces button {
			box-shadow: rgba(0, 0, 0, 0.116) 2px 2px 5px 2px;
			background-color: #fff;
			border-radius: 15px;
			margin-right: 10px;
			padding-top: 4px;
			padding-bottom: 2px;
			padding-right: 10px;
			font-weight: bolder;
			color: #${primaryColor};
		}
		#workspaces button.active {
			padding-right: 20px;
			box-shadow: rgba(0, 0, 0, 0.288) 2px 2px 5px 2px;
			text-shadow: 0px 0px 5px rgba(0, 0, 0, 0.377);
			padding-left: 20px;
			padding-bottom: 3px;
			background: linear-gradient(45deg, rgba(202, 158, 230, 1) 0%, rgba(245, 194, 231, 1) 43%, rgba(180, 190, 254, 1) 80%, rgba(137,180,250,1) 100%);
			background-size: 300% 300%;
			animation: gradient 10s ease infinite;
			color: #fff;
		}

		@keyframes gradient {
			0% {
				background-position: 0% 50%;
			}
			50% {
				background-position: 100% 50%;
			}
			100% {
				background-position: 0% 50%;
			}
		}

		#clock, #battery, #cpu, #memory, #disk, #temperature, #backlight, #network,
		#pulseaudio, #custom-media, #tray, #mode, #idle_inhibitor, #custom-expand,
		#custom-cycle_wall, #custom-ss, #custom-dynamic_pill, #mpd {
			padding: 0 10px;
			border-radius: 15px;
			background-color: #${primaryColor};
			color: white;
			box-shadow: rgba(0, 0, 0, 0.116) 2px 2px 5px 2px;
			margin-top: 10px;
			margin-bottom: 10px;
			margin-right: 10px;
		}
	'';
}
