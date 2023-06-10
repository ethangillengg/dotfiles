{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";

  colorscheme = config.colorscheme;
  wallpaper = config.wallpaper;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    swaybg
    swayidle
    qt6.qtwayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=,highres,auto,1

      general {
        gaps_in=4
        gaps_out=4
        border_size=2.7
        col.active_border=0xff${colorscheme.colors.base0C}
        col.inactive_border=0xff${colorscheme.colors.base02}
        col.group_border_active=0xff${colorscheme.colors.base0B}
        col.group_border=0xff${colorscheme.colors.base04}
        cursor_inactive_timeout=4
      }

      decoration {
        active_opacity=0.94
        inactive_opacity=0.84
        fullscreen_opacity=1.0
        rounding=2
        blur=true
        blur_size=5
        blur_passes=3
        blur_new_optimizations=true
        blur_ignore_opacity=true
        drop_shadow=true
        shadow_range=12
        shadow_offset=3 3
        col.shadow=0x44000000
        col.shadow_inactive=0x66000000
      }

      animations {
          enabled = yes
          bezier = myBezierOld, 0.05, 0.9, 0.1, 1.05
          bezier = myBezier,0.22, 1, 0.36, 1,
          # animation = windows, 1, 5, myBezier
          animation = windows, 1, 5, default, slide
          animation = windowsOut, 1, 4, default, popin 80%
          animation = border, 1, 8, default
          animation = fade, 1, 2, default
          animation = workspaces, 1, 4, default
      }


      bind = SUPER, Return, exec, wezterm
      bind = SUPER, Space, exec, wofi -S drun -W 40% -H 60%
      bind = SUPER, F, fullscreen
      bind = SUPER, W, killactive,
      bind = SUPER, V, togglefloating,
      bind = SUPER, R, togglesplit, # dwindle
      bind = SUPER, M, exec, swaylock -S --clock
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

      # Keyboard controls (brightness, media, sound, etc)
      bind=,XF86MonBrightnessUp,exec,sudo light -A 10
      bind=,XF86MonBrightnessDown,exec,sudo light -U 10

      bind=,XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%
      bind=,XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%
      bind=,XF86AudioMute,exec,${pactl} set-sink-mute @DEFAULT_SINK@ toggle

      # Screenshot
      bind = SUPER, s, exec, ${grim} -g "$(${slurp})" - | wl-copy -t image/png

      blurls=waybar
      blurls=firefox
      layerrule = unset, waybar

      # Startup
      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec=swaybg -i ${wallpaper} --mode fill
      exec-once=mako
      exec-once=waybar
    '';
  };
}
