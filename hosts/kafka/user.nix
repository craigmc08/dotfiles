{ config, lib, inputs, ... }:

{
  imports = [ ../../user ];
  config.modules = {
    packages.enable = true;

    helix.enable = true;
    fish.enable = true;
    direnv.enable = true;
    git.enable = true;
  };
}
