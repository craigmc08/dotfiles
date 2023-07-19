{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.git;

in {
	options.modules.git = { enable = mkEnableOption "git"; };

	config = mkIf cfg.enable {
	  programs.git = {
	    enable = true;
	    userName = "Craig McIlwrath";
	    userEmail = lib.mkDefault "craigmc08@gmail.com";
	    extraConfig = {
	      init.defaultBranch = "main";
	      pull.rebase = true;
	    };
	    ignores = [ ".env" "__scripts" ];
	  };
	};
}
