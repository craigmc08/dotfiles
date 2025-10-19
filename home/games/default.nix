{ config, pkgs, pkgsUnstable, ... }:

{
  home.packages = [
    pkgs.prismlauncher
    pkgsUnstable.temurin-bin-25 # For Minecraft
  ];

  programs.lutris = { enable = true; };
}
