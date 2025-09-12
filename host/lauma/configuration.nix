{ config, pkgs, lib, ... }:

{
  imports = [ ../../system ../../desktop/system.nix ];

  # Switch to grub and scan for other OSs, this host is dual-booted.
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
}
