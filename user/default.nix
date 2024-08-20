{ inputs, pkgs, config, ... }: {
  home.stateVersion = "23.05";
  imports = [
    # gui
    ./firefox
    ./foot # terminal
    ./hyprland # window manager styling/config
    ./spicetify # spotify
    ./discord
    ./minecraft
    ./aseprite

    # cli
    ./helix
    ./fish
    ./direnv
    ./git

    # other
    ./packages
    ./xdg

    # settings
    ./colors.nix
  ];
}
