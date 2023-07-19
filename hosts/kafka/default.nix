{ lib, pkgs, config, inputs, modulesPath, ... }: {
  imports = [
    ../../nixos

    inputs.NixOS-WSL.nixosModules.wsl
    "${modulesPath}/profiles/minimal.nix"
  ];

  wsl = {
    enable = true;
    defaultUser = "craig";
    nativeSystemd = true;
    wslConf.automount.root = "/mnt";
  };
}
