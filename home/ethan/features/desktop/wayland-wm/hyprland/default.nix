{
  config,
  pkgs,
  ...
}: let
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  swaybg = "${pkgs.swaybg}/bin/swaybg";
  cliphist = "${pkgs.cliphist}/bin/cliphist";
  tofi = "${pkgs.tofi}/bin/tofi";
  tofi-drun = "${pkgs.tofi}/bin/tofi-drun";
  pass-tofi = "${pkgs.pass-tofi}/bin/pass-tofi";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  notify-send = "${pkgs.libnotify}/bin/notify-send";

  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  terminal = config.home.sessionVariables.TERMINAL;
  wallpaper = config.wallpaper;

  terminal-spawn = cmd: "${pkgs.wezterm}/bin/wezterm start --always-new-process -e bash -i -c ${cmd}";
  pomodoro-timer = terminal-spawn "${pkgs.pomodoro-sh}/bin/pomodoro-sh";

  brightness-up = "${notify-send} --urgency=normal \"Brightness Up\" \"\$(${brightnessctl} set +5% -m | awk -F ',' '{print $4}')\" --icon=notification-display-brightness --app-name=\"brightness_change\"";
  brightness-down = "${notify-send} --urgency=normal \"Brightness Down\" \"\$(${brightnessctl} set 5%- -m | awk -F ',' '{print $4}')\" --icon=notification-display-brightness --app-name=\"brightness_change\"";

  volume-up = "${notify-send} --urgency=normal \"Volume Up\"  \"$(${wpctl} set-volume @DEFAULT_SINK@ 5%+ -l 1.25 && ${wpctl} get-volume @DEFAULT_SINK@)\" --icon=volume-level-high --app-name=\"vol_change\"";
  volume-down = "${notify-send} --urgency=normal \"Volume Down\"  \"$(${wpctl} set-volume @DEFAULT_SINK@ 5%- && ${wpctl} get-volume @DEFAULT_SINK@)\" --icon=volume-level-medium --app-name=\"vol_change\"";
  volume-mute = "${notify-send} --urgency=normal \"Volume Muted\"  \"$(${wpctl} set-mute @DEFAULT_SINK@ toggle && ${wpctl} get-volume @DEFAULT_SINK@)\" --icon=volume-level-muted --app-name=\"vol_change\"";

  inherit (config.colorscheme) colors;
in {
  imports = [
    ./basic-binds.nix
    ./systemd-fixes.nix
  ];

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
      exec = [
        "${swaybg} -i ${wallpaper} --mode fill"
        # exec-once=wezterm
      ];
      bind = [
        # Keyboard controls (brightness, media, sound, etc)
        ",XF86AudioMute,exec,${volume-mute}"

        "SUPER, Return, exec, ${terminal}"
        "SUPER, Space, exec, ${tofi-drun} --drun-launch=true --prompt-text \"Launch: \""
        "SUPER, M, exec, ${swaylock} -S --clock" # lock screen
        "SUPER, s, exec, ${grim} -g \"$(${slurp})\" - | wl-copy -t image/png" # Screenshot
        "SUPER, semicolon, exec, ${pass-tofi}" # Password manager
        "SUPER, Y, exec, ${cliphist} list | ${tofi} --prompt-text \"Clipboard: \" | ${cliphist} decode | wl-copy" # Clipboard history

        "SUPER SHIFT, P, exec, [workspace special;float] ${pomodoro-timer}"
      ];

      # Repeating
      binde = [
        ",XF86MonBrightnessUp,exec,${brightness-up}"
        ",XF86MonBrightnessDown,exec,${brightness-down}"

        ",XF86AudioRaiseVolume,exec,${volume-up}"
        ",XF86AudioLowerVolume,exec,${volume-down}"
      ];
    };
    extraConfig = ''
      monitor=,highres,auto,1
      layerrule = noanim, launcher
      windowrule=opacity 1.0 override 0.9 override,^(.*)(qutebrowser|firefox)(.*)$

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
      bind = SUPER, bracketright, workspace, e+1
      bind = SUPER, bracketleft, workspace, e-1

      # lock when lid closed
      bindl=,switch:Lid Switch,exec, ${swaylock} -S --clock

      blurls=waybar
      blurls=firefox
      blurls=qutebrowser

      # Startup
      exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once=mako

      # Clipboard manager
      exec-once = wl-paste --type text --watch ${cliphist} store #Stores only text data
      exec-once = wl-paste --type image --watch ${cliphist} store #Stores only image data

    '';
  };
}
