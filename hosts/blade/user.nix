{ config, lib, inputs, ... }:

{
  imports = [ ../../user ../../user/colors/ice.nix ];
  config.modules = {
    firefox.enable = true;
    foot.enable = true;
    hyprland.enable = true;
    spicetify.enable = true;
    discord.enable = true;

    helix.enable = true;
    fish.enable = true;
    direnv.enable = true;
    git.enable = true;

    packages.enable = true;
    xdg.enable = true;
  };
}
