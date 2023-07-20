{ config, pkgs, lib, ... }:

with lib;
let dependencies = with pkgs; [
		cfg.package

		bash
		brillo
		coreutils
		dbus
		findutils
		gawk
		imagemagick
		jaq
		jc
		libnotify
		networkmanager
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

	cfg = config.modules.eww;

in {
	options.modules.eww = {
		package = mkOption {
			default = pkgs.eww-wayland;
		};

    colors = mkOption {
      default = ''
      /* TODO eww scss colors */
      '';
      description = "SCSS code for eww colors.";
    };
	};

	config = {
		home.packages = [cfg.package];

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
				Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
				ExecStart = "${cfg.package}/bin/eww daemon --no-daemonize";
				Restart = "on-failure";
			};
			Install.WantedBy = ["graphical-session.target"];
		};
	};
}
