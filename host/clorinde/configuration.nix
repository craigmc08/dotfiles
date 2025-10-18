{ config, pkgs, lib, ... }:

{
  imports = [ ../../system ../../desktop/system.nix ];

  # Switch to grub and scan for other OSs, this host is dual-booted.
  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # useOSProber = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };
}
