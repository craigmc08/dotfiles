{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
  # hyprland is installed system-wide, so this doesn't need to install it
  # This module is just for configuration.

  options.modules.hyprland = {
    enable = mkEnableOption "hyprland";

    style = {
      primaryColor = mkOption { default = "33ccff"; };
      primaryColorLight = mkOption {
        default = "00ff99";
        description = "Used in gradients with primaryColor";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ wl-clipboard dunst ];

    # dunst (notifications)
    services.dunst = { enable = true; };

    # waybar (status bar)
    programs.waybar.enable = true;

    # wofi (launcher/menu)
    programs.wofi = {
      enable = true;
      inherit (import ./wofi.nix {
        inherit lib;
        config = cfg;
      })
        settings style;
    };

    # hyprland configuration
    home.file.".config/hypr/hyprland.conf".text = ''
      # TODO if i have devices with diff monitors, what to do?
      monitor=eDP-1,1920x1080@60,0x0,1

      # TODO pick a wallpaper
      # swaybg -i $NIXOS_CONFIG_DIR/pics/wallpaper.png
      exec-once=foot --server
      exec-once=dust

      input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options = caps:escape
        kb_rules =

        touchpad {
          natural_scroll=no
        }
      }

      general {
        sensitivity = 1.0 # mouse cursor
        apply_sens_to_raw = 0 # do not apply sensitivity to raw mouse input mode

      	gaps_in = 8
      	gaps_out = 15
      	border_size = 5
      	col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      	col.inactive_border = rgba(595959aa)

      	layout = dwindle
      }

      decoration {
      	rounding = 15

      	blur = 0
      	blur_size = 1
      	blur_passes = 1
      	blur_new_optimizations = true

      	drop_shadow = true
      	shadow_range = 100
      	shadow_render_power = 5
      	col.shadow = rgba(000000ee)
        col.shadow_inactive = rgba(00000022)
      }

      animations {
      	enabled = true

      	bezier = overshot, 0.05, 0.9, 0.1, 1.1

      	animation = windows, 1, 4, overshot, slide
      	animation = border, 1, 10, default
      	animation = fade, 1, 10, default
      	animation = workspaces, 1, 6, overshot, slidevert
      }

      dwindle {
      	pseudotile = true
        force_split = 0
      }

      master {
      }

      $mainMod = SUPER

      # Exit Hyprland with Super+Q
      bind = $mainMod,Q,exit
      # Open terminal with Super+T
      bind = $mainMod,T,exec,footclient
      # Open app launcher with Super+Space
      bind = $mainMod,Space,exec,wofi --show drun

      # Move focus with Super + H,J,K,L
      bind = $mainMod,H,movefocus,l
      bind = $mainMod,J,movefocus,d
      bind = $mainMod,K,movefocus,u
      bind = $mainMod,L,movefocus,r

      bind = $mainMod SHIFT,H,swapwindow,l
      bind = $mainMod SHIFT,J,swapwindow,d
      bind = $mainMod SHIFT,K,swapwindow,u
      bind = $mainMod SHIFT,L,swapwindow,r

      # Swap through workspaces with Super + F, B
      bind = $mainMod,F,workspace,e+1
      bind = $mainMod,B,workspace,e-1
      		'';
  };
}
