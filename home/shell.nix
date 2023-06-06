{ lib, pkgs, config, inputs, ... }: {
  home.sessionVariables = {
    # exa
    TIME_STYLE = "iso";

    # helix
    EDITOR = "hx";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    plugins = [
      { name = "bobthefish"; src = pkgs.fishPlugins.bobthefish.src; }
    ];

    functions = {
      ll = "exa -aagl $argv";
      lll = "exa -glT --level=2 $argv";
    };
  };
}
