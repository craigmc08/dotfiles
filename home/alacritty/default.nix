{ config, pks, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = { x = 8; y = 8; };
      };

      font = {
        normal = { family = "BlexMono Nerd Font"; };
      };

      colors = {
        primary = {
          foreground = "#e5ded6";
          background = "#161c23";
        };

        normal = {
          black = "#13181e"; # black
          red = "#d32c4d"; # red
          green = "#57a331"; # green
          yellow = "#dc7759"; # yellow
          blue = "#36b2d4"; # blue
          magenta = "#b759dc"; # magenta
          cyan = "#23a580"; # cyan
          white = "#c6b8ad"; # white
        };

        bright = {
          black = "#313f4e";
          red = "#dc597f";
          green = "#7fdc59";
          yellow = "#dcb659";
          blue = "#59dcd8";
          magenta = "#dc59c0";
          cyan = "#59dcb7";
          white = "#e5ded6";
        };
      };
    };
  };
}
