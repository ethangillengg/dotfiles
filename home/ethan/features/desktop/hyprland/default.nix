{ inputs, lib, config, pkgs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    swaybg
    swayidle
    swaylock
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=eDP-1,1920x1080@60,0x0,1

      bind = SUPER, Return, exec, wezterm
      bind = SUPER, Space, exec, wofi -S drun -W 40% -H 60% 
      bind = SUPER, F, fullscreen
      bind = SUPER, W, killactive, 
      bind = SUPER, V, togglefloating, 
      bind = SUPER, R, togglesplit, # dwindle
      bind = SUPER, M, exec, swaylock
      bind = SUPER_SHIFT, M, exit, 

      # Move focus with SUPER + arrow keys
      bind = SUPER, left, movefocus, l
      bind = SUPER, H, movefocus, l
      bind = SUPER, right, movefocus, r
      bind = SUPER, L, movefocus, r
      bind = SUPER, up, movefocus, u
      bind = SUPER, J, movefocus, u
      bind = SUPER, down, movefocus, d
      bind = SUPER, K, movefocus, d

      # Move window
      bind = SUPER_SHIFT, H, movewindow, l
      bind = SUPER_SHIFT, L, movewindow, r
      bind = SUPER_SHIFT, J, movewindow, d
      bind = SUPER_SHIFT, K, movewindow, u

      # Switch workspaces with SUPER + [0-9]
      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10

      # Move active window to a workspace with SUPER + SHIFT + [0-9]
      bind = SUPER SHIFT, 1, movetoworkspace, 1
      bind = SUPER SHIFT, 2, movetoworkspace, 2
      bind = SUPER SHIFT, 3, movetoworkspace, 3
      bind = SUPER SHIFT, 4, movetoworkspace, 4
      bind = SUPER SHIFT, 5, movetoworkspace, 5
      bind = SUPER SHIFT, 6, movetoworkspace, 6
      bind = SUPER SHIFT, 7, movetoworkspace, 7
      bind = SUPER SHIFT, 8, movetoworkspace, 8
      bind = SUPER SHIFT, 9, movetoworkspace, 9
      bind = SUPER SHIFT, 0, movetoworkspace, 10


      # Scroll through existing workspaces with mainMod + scroll
      bind = SUPER, mouse_down, workspace, +1
      bind = SUPER, mouse_up, workspace, -1
      bind = SUPER, bracketright, workspace, +1
      bind = SUPER, bracketleft, workspace, -1

      # Move/resize windows with SUPER + LMB/RMB and dragging
      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow

      general {
          gaps_in = 5
          gaps_out = 10
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          layout = dwindle
      }

      decoration {
          rounding = 10
          blur = yes
          blur_size = 3
          blur_passes = 1
          blur_new_optimizations = on

          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes
          bezier = myBezierOld, 0.05, 0.9, 0.1, 1.05
          bezier = myBezier,0.22, 1, 0.36, 1,
          animation = windows, 1, 5, myBezier
          animation = windowsOut, 1, 4, default, popin 80%
          animation = border, 1, 8, default
          animation = fade, 1, 2, default
          animation = workspaces, 1, 4, default
      }
    '';
  };
}

