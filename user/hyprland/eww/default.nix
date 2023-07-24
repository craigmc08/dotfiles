{ config, pkgs, lib, inputs, ... }:

with lib;
let dependencies = with pkgs; [
		inputs.gross.packages.${pkgs.system}.gross
		cfg.package

		
    bash
    blueberry
    bluez
    brillo
    coreutils
    dbus
    findutils
    gawk
    gnome.gnome-control-center
    gnused
    imagemagick
    jaq
    jc
    libnotify
    networkmanager
    pavucontrol
    playerctl
    procps
    pulseaudio
    ripgrep
    socat
    udev
    upower
    util-linux
    wget
    wireplumber
    wlogout
	];

	reloadScript = pkgs.writeShellScript "reload_eww" ''
		windows=$(eww windows | rg '\*' | tr -d '*')

		systemctl --user restart eww.service

		echo $windows | while read -r w; do
			eww open $w
		done
	'';

	cfg = config.modules.eww;
	colors = config.modules.colors;

in {
	options.modules.eww = {
		package = mkOption {
			default = inputs.eww.packages.${pkgs.system}.eww-wayland;
		};
	};

	config = {
		home.packages = dependencies;

		# Copy all files from this directory (except for *.nix files) to eww config
		# directory.
		xdg.configFile."eww" = {
			source = lib.cleanSourceWith {
				filter = name: _type:
					let baseName = baseNameOf (toString name);
					in !(lib.hasSuffix ".nix" baseName);
				src = lib.cleanSource ./.;
			};

			# symlink files within the directory, not the directory itself.
			recursive = true;
		};

		systemd.user.services.eww = {
			Unit = {
				Description = "Eww Daemon";
				PartOf = ["graphical-session.target"];
			};
			Service = {
				ExecStart = "${cfg.package}/bin/eww daemon --no-daemonize";
				Restart = "on-failure";
			};
			Install.WantedBy = ["graphical-session.target"];
		};

		# colors file
		xdg.configFile."eww/css/_colors.scss".text = ''
			$bg: ${colors.bg};
			$bg1: ${colors.bgLight};
			$fg: ${colors.fg};
			$fgLight: ${colors.fgLight};
			$text: ${colors.text};
			$subtext: ${colors.subtext};
			$accent: ${colors.accent};

			$wsEmpty: ${colors.bar.workspace.empty};
			$ws1: ${colors.bar.workspace.monitor1};
			$ws2: ${colors.bar.workspace.monitor2};
			$ws3: ${colors.bar.workspace.monitor3};
			$ws4: ${colors.bar.workspace.monitor4};
			$wsActive1: ${colors.bar.workspace.active1};
			$wsActive2: ${colors.bar.workspace.active2};
			$wsActive3: ${colors.bar.workspace.active3};

			$bright: ${colors.bar.system.brightness};
			$volume: ${colors.bar.system.volume};
			$bluetooth: ${colors.bar.system.bluetooth};
			$wifi: ${colors.bar.system.wifi};

			$cpu: ${colors.bar.system.cpu};
			$mem: ${colors.bar.system.mem};
			$battery: ${colors.bar.system.battery};
			$batteryCharging: ${colors.bar.system.batteryCharging};
			$batteryLow: ${colors.bar.system.batteryCritical};

			$clock: ${colors.bar.clock};
			$date: ${colors.bar.date};
		'';
	};
}
