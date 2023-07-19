{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
  # hyprland is installed system-wide, so this doesn't need to install it
  # This module is just for configuration.

  options.modules.hyprland = { enable = mkEnableOption "hyprland"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wl-clipboard dunst wofi ];

    # dunst (notifications)
    services.dunst = { enable = true; };

    # waybar (status bar)
    programs.waybar.enable = true;

    # wofi (launcher/menu)
    home.file.".config/wofi.css".text = "";

    # hyprland configuration
    home.file.".config/hypr/hyprland.conf".text = ''
      # TODO if i have devices with diff monitors, what to do?
      monitor=DP-1,1920x1080@60,0x0,1.5

      # TODO pick a wallpaper
      # swaybg -i $NIXOS_CONFIG_DIR/pics/wallpaper.png
      exec-once=foot --server
      exec-once=dust

      general {
      	gaps_in = 5
      	gaps_out = 20
      	border_size  = 2
      	col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      	col.inactive_border = rgba(595959aa)

      	layout = dwindle
      }

      decoration {
      	rounding = 10
      	blur = true
      	blur_size = 3
      	blur_passes = 1
      	blur_new_optimizations = true

      	drop_shadow = true
      	shadow_range = 4
      	shadow_render_power = 3
      	col.shadow = rgba(1a1a1aee)
      }

      animations {
      	enabled = true

      	bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      	animation = windows, 1, 7, myBezier
      	animation = windowsOut, 1, 7, default, popin 80%
      	animation = border, 1, 10, default
      	animation = borderangle, 1, 8, default
      	animation = fade, 1, 7, default
      	animation = workspaces, 1, 6, default
      }

      dwindle {
      	pseudotile = true
      	preserve_split = true
      }

      master {
      	new_is_master = true
      }

      $mainMod = SUPER

      # Exit Hyprland with Super+Q
      bind = $mainMod,Q,exit
      # Open terminal with Super+T
      bind = $mainMod,T,exec,footclient
      # Open app launcher with Super+Space
      bind = $mainMod,Space,exec,wofi --show run

      # Move focus with Super + H,J,K,L
      bind = $mainMod,H,movefocus,l
      bind = $mainMod,J,movefocus,d
      bind = $mainMod,K,movefocus,u
      bind = $mainMod,L,movefocus,r

      # Swap through workspaces with Super + F, B
      bind = $mainMod,F,workspace,e+1
      bind = $mainMod,B,workspace,e-1
      		'';
  };
}
