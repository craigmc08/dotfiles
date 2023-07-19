{ lib, pkgs, config, ... }: {
	imports = [ ../../system ];

	config.modules = {
		system.enable = true;
		system.hardware.enable = true;
	};
}
