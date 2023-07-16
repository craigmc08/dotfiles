{ config, lib, pkgs, inputs, ... }: {
  imports = [
    ../shared.nix

    ./craig.nix
  ];

  environment = {
    defaultPackages = lib.mkForce [ ];
    shellAliases = lib.mkForce { };
    systemPackages = [
      pkgs.git
      pkgs.unstable.helix
      pkgs.nano
      pkgs.wget
    ];

    # For direnv fish integration.
    pathsToLink = [ "/share/fish" ];
  };

  nix = {
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes" ];

      # Protect direnv shells from GC.
      keep-outputs = true;
      keep-derivations = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 14d";
    };
  };

  programs = {
    fish = {
      enable = true;
      shellInit = ''
        set -gx EDITOR hx
      '';
    };
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flags = (
      lib.concatMap
        (input: ["--update-input" input ])
        (lib.remove "self" (builtins.attrNames inputs))
    );
    flake = "/etc/nixos";
  };

  system.stateVersion = lib.mkDefault "23.05";

  time.timeZone = "America/New_York";

  users.defaultUserShell = pkgs.fish;
}
