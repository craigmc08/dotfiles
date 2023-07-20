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

in {
	options.modules.eww = {
		package = mkOption {
			default = inputs.eww.packages.${pkgs.system}.eww-wayland;
		};

    colors = mkOption {
      default = ''
      /* TODO eww scss colors */
      '';
      description = "SCSS code for eww colors.";
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

		# colors file
		xdg.configFile."eww/css/_colors.scss".text = cfg.colors;

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
	};
}
