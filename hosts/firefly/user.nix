{ config, lib, inputs, ... }:

{
  imports = [ ../../user ../../user/colors/ice.nix ];
  config.modules = {
    # firefox.enable = true;
    # spicetify.enable = true;
    discord.enable = true;
    # minecraft.enable = true;
    # aseprite.enable = true;
    # wezterm.enable = true; # TODO: reenable when font rendering is fixed
    niri.enable = true;

    helix.enable = true;
    fish.enable = true;
    direnv.enable = true;
    git.enable = true;
    jj.enable = true;

    packages.enable = true;
  };
}
