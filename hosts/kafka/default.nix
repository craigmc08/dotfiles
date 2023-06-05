{ lib, pkgs, config, inputs, modulesPath, ... }: {
  imports = [
    ../../nixos

    inputs.NixOS-WSL.nixosModules.wsl
    "${modulesPath}/profiles/minimal.nix"
  ];

  networking.hostName = "kafka";

  wsl = {
    enable = true;
    defaultUser = "craig";
    nativeSystemd = true;
    wslConf.automount.root = "/mnt";
  };
}
