{ config, pkgs, ... }: {
  programs.helix = { enable = true; };

  xdg.configFile."helix/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.dotfiles}/home/helix/config.toml";
  xdg.configFile."helix/themes/nightsky.toml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.dotfiles}/home/helix/nightsky.toml";
}
