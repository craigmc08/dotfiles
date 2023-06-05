{ lib, pkgs, config, inputs, ... }: {
  home.sessionVariables = {
    fish_greeting = "";

    EDITOR = "hx";
  };

  programs.fish = {
    enable = true;
  };
}
