{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.system;

in {
  options.modules.system = {
    enable = mkEnableOption "system";
    hardware = {
      enable = mkEnableOption "boot";
    };

    desktop = {
      hyprland.enable = mkEnableOption "hyprland";
      kde.enable = mkEnableOption "kde";
    };

    programs = {
      steam.enable = mkEnableOption "steam";
    };

    nvidia = {
      enable = mkEnableOption "nvidia";
      package = mkPackageOption pkgs "nvidia" {
        default = null;
        example = "pkgs.config.boot.kernelPackages.nvidiaPackages.stable";
      };

      intelBusId = mkOption {
        default = null;
        example = "PCI:0:2:0";
      };
      nvidiaBusId = mkOption {
        default = null;
        example = "PCI:0:2:0";
      };
    };
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
        extraGroups = [ "wheel" "networkmanager" "video" "transmission" "input" ];
      };
    })
    (mkIf cfg.hardware.enable {
      # System settings for NixOS that is a real operating system (as opposed to
      # running in WSL or something).

      # Allow spotify and discord to be installed.
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "spotify"
        "discord"
        "steam"
        "steam-original"
        "steam-run"
        "nvidia-x11"
        "nvidia-settings"
        "nvidia-persistenced"
        "aseprite"
      ];

      # Enable printing.
      services.printing.enable = true;

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
          material-symbols
          fira-code
          agave
          (nerdfonts.override { fonts = [ "FiraCode" "Agave" ]; })
        ];

        fontconfig = {
          hinting.autohint = true;
          defaultFonts = { emoji = [ "OpenMoji Color" ]; };
        };
      };


      # Smooth backlight control
      hardware.brillo.enable = true;

      # Networking
      networking = { networkmanager.enable = true; };

      # Bluetooth
      hardware.bluetooth = {
        enable = true;
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
    (mkIf cfg.desktop.hyprland.enable {
      # Hyprland
      programs.hyprland = { enable = true; };
    })
    (mkIf cfg.desktop.kde.enable {
      # KDE
      services.xserver = {
        enable = true;
        displayManager.sddm.enable = true;
        desktopManager.plasma5.enable = true;
      };
    })
    (mkIf cfg.programs.steam.enable {
      nixpkgs.config.packageOverrides = pkgs: {
        steam = pkgs.steam.override {
          extraPkgs = pkgs: with pkgs; [
            cups # needed for Vampire Survivors
          ];
        };
      };
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
    })
    (mkIf cfg.nvidia.enable {
      hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };

      # Load nvidia driver for Xorg and Wayland
      # TODO: need an option to choose e.g. "nvidiaLegacy470"
      services.xserver.videoDrivers = ["nvidia"];

      hardware.nvidia = {
        modesetting.enable = true;

        # Enable if having corruptions or crashes on wake.
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = false;

        # access with `nvidia-settings`
        nvidiaSettings = true;

        package = cfg.nvidia.package;

        # for hybrid laptops
        # TODO: make it possible to choose whether to use prime or not in cfg
        prime = {
          sync.enable = true;

          intelBusId = cfg.nvidia.intelBusId;
          nvidiaBusId = cfg.nvidia.nvidiaBusId;
        };
      };
    })
  ];
}
