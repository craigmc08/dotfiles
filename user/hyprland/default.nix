{ lib, pkgs, config, ... }:

with lib;
let cfg = config.modules.hyprland;

in {
  # hyprland is installed system-wide, so this doesn't need to install it
  # This module is just for configuration.

  imports = [./eww];

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
      exec-once=eww open bar
      exec-once=dunst

      input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options = caps:escape
        kb_rules =

        touchpad {
          natural_scroll=yes
        }
      }

      general {
        sensitivity = 1.0 # mouse cursor
        apply_sens_to_raw = 0 # do not apply sensitivity to raw mouse input mode

      	gaps_in = 5
      	gaps_out = 5
      	border_size = 2
      	col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      	col.inactive_border = rgba(595959aa)

      	layout = dwindle
      }

      decoration {
      	rounding = 15

      	blur = true
      	blur_size = 3
      	blur_passes = 1
      	blur_new_optimizations = true

      	drop_shadow = true
        shadow_ignore_window = true
      	shadow_range = 100
      	shadow_render_power = 5
      	col.shadow = rgba(00000099)
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

      # Exit Hyprland with Super+Shift+Q
      bind = $mainMod SHIFT,Q,exit
      # Open terminal with Super+T
      bind = $mainMod,T,exec,footclient
      # Open app launcher with Super+Space
      bind = $mainMod,Space,exec,wofi --show drun
      # Close active app with Super+Q
      bind = $mainMod,Q,killactive

      # Move focus with Super + H,J,K,L
      bind = $mainMod,H,movefocus,l
      bind = $mainMod,J,movefocus,d
      bind = $mainMod,K,movefocus,u
      bind = $mainMod,L,movefocus,r

      # Move active window with Super + Shift + H,J,K,L
      bind = $mainMod SHIFT,H,swapwindow,l
      bind = $mainMod SHIFT,J,swapwindow,d
      bind = $mainMod SHIFT,K,swapwindow,u
      bind = $mainMod SHIFT,L,swapwindow,r

      # Resize active window with Super + Ctrl + H,J,K,L
      binde = $mainMod CTRL,H,resizeactive,-20 0
      binde = $mainMod CTRL,J,resizeactive,0 20
      binde = $mainMod CTRL,K,resizeactive,0 -20
      binde = $mainMod CTRL,L,resizeactive,20 0

      # Cycle through workspaces with Super + [ or ]
      bind = $mainMod,bracketleft,workspace,e+1
      bind = $mainMod,bracketright,workspace,e-1

      # move windows with mouse (move = super + left, resize = super + right or super + alt + left)
      bindm = $mainMod,mouse:272,movewindow
      bindm = $mainMod,mouse:273,resizewindow
      bindm = $mainMod ALT,mouse:272,resizewindow

      # switch to/move windows to workspace with Super + (Alt +) Number
      bind = $mainMod,1,workspace,1
      bind = $mainMod,2,workspace,2
      bind = $mainMod,3,workspace,3
      bind = $mainMod,4,workspace,4
      bind = $mainMod,5,workspace,5
      bind = $mainMod,6,workspace,6
      bind = $mainMod,7,workspace,7
      bind = $mainMod,8,workspace,8
      bind = $mainMod,9,workspace,9
      bind = $mainMod,0,workspace,0


      bind = $mainMod SHIFT,1,movetoworkspace,1
      bind = $mainMod SHIFT,2,movetoworkspace,2
      bind = $mainMod SHIFT,3,movetoworkspace,3
      bind = $mainMod SHIFT,4,movetoworkspace,4
      bind = $mainMod SHIFT,5,movetoworkspace,5
      bind = $mainMod SHIFT,6,movetoworkspace,6
      bind = $mainMod SHIFT,7,movetoworkspace,7
      bind = $mainMod SHIFT,8,movetoworkspace,8
      bind = $mainMod SHIFT,9,movetoworkspace,9
      bind = $mainMod SHIFT,0,movetoworkspace,0
  		'';
  };
}
