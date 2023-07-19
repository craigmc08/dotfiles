{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.system;

in {
	options.modules.system = {
		enable = mkEnableOption "system";
		hardware = { enable = mkEnableOption "boot"; };
	};

	config = mkMerge [
		(mkIf cfg.enable {
			# Remove default bloat.
			environment.defaultPackages = [ ];
			environment.shellAliases = { };
			environment.systemPackages = [ pkgs.git pkgs.nano ];
			services.xserver.desktopManager.xterm.enable = false;

			# Fish shell by default.
			programs.fish.enable = true;
			environment.pathsToLink = [ "/share/fish" ]; # For direnv integration.
			users.defaultUserShell = pkgs.fish;

			# Nix settings: auto gc, flakes, keep shells around.
			nix = {
				settings = {
					allowed-users = [ "@wheel" ];
					auto-optimise-store = true;
					experimental-features = [ "nix-command" "flakes" ];

					keep-outputs = true;
					keep-derivations = true;
				};
				gc = {
					automatic = true;
					dates = "weekly";
					options = "--delete-older-than 7d";
				};
			};

			system.stateVersion = lib.mkDefault "23.05";

			# Locales
			time.timeZone = "America/New_York";

			# User setup.
			users.users.craig = {
				isNormalUser = true;
				extraGroups = [ "wheel" ];
			};
		})
		(mkIf cfg.hardware.enable {
			# System settings for NixOS that is a real operating system (as opposed to
			# running in WSL or something).

			# Make bootable.
			boot = {
				kernelParams = [ "consoleblank=30" ];
				loader = {
					systemd-boot.enable = true;
					efi.canTouchEfiVariables = true;
				};
			};

			fonts = {
				fonts = with pkgs; [
					roboto
					openmoji-color
					fira-code
				];

				fontconfig = {
					hinting.autohint = true;
					defaultFonts = {
						emoji = [ "OpenMoji Color" ];
					};
				};
			};

		  # X11
		  services.xserver.enable = true;

		  # Pantheon
		  services.xserver.displayManager.lightdm.enable = true;
		  services.xserver.desktopManager.pantheon.enable = true;

		  services.xserver = {
		    layout = "us";
		    xkbVariant = "";
		  };

			# Sound.
			sound.enable = true;
			hardware.pulseaudio.enable = false;
			security.rtkit.enable = true;
			services.pipewire = {
				enable = true;
				alsa.enable = true;
				alsa.support32Bit = true;
				pulse.enable = true;
			};

			# Enable OpenGL.
			hardware = {
				opengl = {
					enable = true;
					driSupport = true;
				};
			};
		})
	];
}
