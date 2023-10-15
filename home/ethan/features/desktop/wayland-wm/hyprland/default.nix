{
  inputs,
  config,
  pkgs,
  ...
}: let
  pactl = "${pkgs.pulseaudio}/bin/pactl";
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  swaybg = "${pkgs.swaybg}/bin/swaybg";
  cliphist = "${pkgs.cliphist}/bin/cliphist";
  tofi = "${pkgs.tofi}/bin/tofi";
  tofi-drun = "${pkgs.tofi}/bin/tofi-drun";
  pass-tofi = "${pkgs.pass-tofi}/bin/pass-tofi";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";

  wallpaper = config.wallpaper;
  inherit (config.colorscheme) colors;
in {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      general = {
        gaps_in = 8;
        gaps_out = 4;
        border_size = 2.7;
        cursor_inactive_timeout = 4;
        "col.active_border" = "0xff${colors.base0C}";
        "col.inactive_border" = "0xff${colors.base02}";
      };

      decoration = {
        active_opacity = 0.92;
        inactive_opacity = 0.75;
        fullscreen_opacity = 1.0;
        rounding = 1;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
        };
        drop_shadow = true;
        shadow_range = 12;
        shadow_offset = "3 3";
        "col.shadow" = "0x44000000";
        "col.shadow_inactive" = "0x66000000";
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.22, 1, 0.36, 1,";
        # animation = "windows, 1, 5, myBezier";
        animation = [
          "windows, 0, 5, default, slide"
          "windowsIn, 1, 1, default, popin"
          "windowsOut, 1, 2, default, popin"
          "windowsMove, 1, 2, default, slide"
          "border, 1, 8, default"
          "fade, 1, 2, default"
          "workspaces, 1, 2, default, slidefade"
        ];
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      input = {
        repeat_rate = 35;
        repeat_delay = 250;
      };
    };
    bind = [
      "SUPER, Return, exec, wezterm"
      "SUPER, Space, exec, ${tofi-drun} --drun-launch=true --prompt-text \"Launch: \""
      "SUPER, M, exec, swaylock -S --clock"
    ];
    extraConfig = ''
      monitor=,highres,auto,1
      layerrule = noanim, launcher






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


      # Keyboard controls (brightness, media, sound, etc)
      bind=,XF86MonBrightnessUp,exec,${brightnessctl} set 5%-
      bind=,XF86MonBrightnessDown,exec,${brightnessctl} set +5%

      bind=,XF86AudioRaiseVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ +5%
      bind=,XF86AudioLowerVolume,exec,${pactl} set-sink-volume @DEFAULT_SINK@ -5%
      bind=,XF86AudioMute,exec,${pactl} set-sink-mute @DEFAULT_SINK@ toggle

      # Screenshot
      bind = SUPER, s, exec, ${grim} -g "$(${slurp})" - | wl-copy -t image/png
      # Password manager
      bind = SUPER, semicolon, exec, ${pass-tofi}
      # Clipboard history
      bind = SUPER, Y, exec, ${cliphist} list | ${tofi} --prompt-text "Clipboard: " | ${cliphist} decode | wl-copy

      # trigger when the switch is turning off
      bindl = , switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, 1920x1080, 0x0, 1"
      # trigger when the switch is turning on
      bindl = , switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable"


      blurls=waybar
      blurls=firefox

      # Startup
      exec=${swaybg} -i ${wallpaper} --mode fill
      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once=mako
      exec-once=waybar
      exec-once=wezterm
      # Clipboard manager
      exec-once = wl-paste --type text --watch ${cliphist} store #Stores only text data
      exec-once = wl-paste --type image --watch ${cliphist} store #Stores only image data

    '';
  };
}
