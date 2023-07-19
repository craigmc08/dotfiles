{ inputs, pkgs, config, ... }: {
  home.stateVersion = "23.05";
  imports = [
    # gui

    # cli
    ./helix
    ./fish
    ./direnv
    ./git

    # other
    ./packages
  ];
}
