{ config, lib, pkgs, inputs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      unstable = import inputs.unstable-pkgs { system = final.system; };
    })
  ];
}
