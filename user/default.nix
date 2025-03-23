{ inputs, pkgs, config, ... }: {
  home.username = "craig";
  home.homeDirectory = "/home/craig";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  imports = [
    # gui
    ./firefox
    ./foot # terminal
    ./spicetify # spotify
    ./discord
    ./minecraft
    ./aseprite
    ./wezterm
    ./niri

    # cli
    ./helix
    ./fish
    ./direnv
    ./git
    ./jj

    # other
    ./packages
    ./xdg

    # settings
    ./colors.nix
  ];
}
