{ lib, pkgs, config, inputs, modulesPath, ... }: {
	imports = [
		../../system

		inputs.NixOS-WSL.nixosModules.wsl
		"${modulesPath}/profiles/minimal.nix"
	];

	config= {
		modules = { system.enable = true; };

		wsl = {
			enable = true;
			defaultUser = "craig";
			nativeSystemd = true;
			wslConf.automount.root = "/mnt";
		};
	};
}
