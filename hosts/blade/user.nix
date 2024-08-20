{ config, lib, inputs, ... }:

{
  imports = [ ../../user ];
  config.modules = {
    firefox.enable = true;
    foot.enable = true;
    hyprland.enable = true;
    spicetify.enable = true;
    discord.enable = true;
    minecraft.enable = true;
    aseprite.enable = true;

    helix.enable = true;
    fish.enable = true;
    direnv.enable = true;
    git.enable = true;

    packages.enable = true;
    xdg.enable = true;
  };
}
