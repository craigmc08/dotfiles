{ lib, pkgs, config, inputs, ... }: {
  home.sessionVariables = {
    # exa
    TIME_STYLE = "iso";

    # helix
    EDITOR = "hx";
  };

  programs.starship = {
    enable = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';

    functions = {
      ll = "exa -aagl $argv";
      lll = "exa -glT --level=2 $argv";
    };
  };
}
