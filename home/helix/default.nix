{ config, pkgs, ... }:
{
  programs.helix = {
    enable = true;
  };
  
  home = {
    file = {
      "~/.config/helix/config.toml".source = config.lib.file.mkOutOfStoreSymlink ./config.toml;
    };
  };
}
