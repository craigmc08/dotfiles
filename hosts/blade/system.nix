{ lib, pkgs, config, ... }: {
  imports = [ ../../system ];

  config.modules = {
    system.enable = true;
    system.hardware.enable = true;

    # system.desktop.hyprland.enable = true;
    system.desktop.kde.enable = true;

    system.programs.steam.enable = true;

    system.nvidia = {
      enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
