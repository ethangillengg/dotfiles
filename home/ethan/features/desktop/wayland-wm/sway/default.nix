{
  config,
  pkgs,
  ...
}: let
  # Dependencies
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  tofi-drun = "${pkgs.tofi}/bin/tofi-drun";
  pass-tofi = "${pkgs.pass-tofi}/bin/pass-tofi";
  terminal = config.home.sessionVariables.TERMINAL;
  wallpaper = config.wallpaper;
  swayidle = "${pkgs.swayidle}/bin/swayidle";
  wlsunset = "${pkgs.wlsunset}/bin/wlsunset";

  ## Modes
  system = "(l) lock, (e) logout, (s) shutdown";

  ## Lock
  lock = "${config.programs.swaylock.package}/bin/swaylock --clock -f -i ${wallpaper} --scaling fill -F";

  modifier = "Mod4";
  inherit (config.colorscheme) colors;
in {
  imports = [
    ./extras.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    systemd.enable = true;
    extraSessionCommands = ''
      export XDG_CURRENT_DESKTOP=sway
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    '';

    config = {
      inherit modifier;
      input = {
        "*" = {
          repeat_rate = "35";
          repeat_delay = "250";
        };
      };

      output = {
        "*".bg = "${wallpaper} fit";

        "DP-2" = {
          mode = "2560x1440@100Hz";
        };
      };

      gaps = {
        inner = 16;
        outer = 4;
        smartGaps = true;
      };

      colors = {
        focused = {
          # The border around the title bar.
          border = "#ffffff";

          # The text color of the title bar.
          text = "#ffffff";

          # The background of the title bar.
          background = "#285577";

          # The border around the view itself.
          childBorder = "#${colors.base0C}";

          # The color used to indicate where a new view will open.
          # In a tiled container, this would paint the right border
          # of the current view if a new view would be opened to the right.
          indicator = "#${colors.base0C}";
        };
      };

      # Drag floating windows by holding down $mod and left mouse button.
      # Resize them with right mouse button + $mod.
      # Despite the name, also works for non-floating windows.
      # Change normal to inverse to use left mouse button for resizing and right
      # mouse button for dragging.
      floating.modifier = "${modifier}";

      # Disable swaybar since I am using waybar instead
      bars = [];

      keybindings = {
        ## Basics
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Space" = "exec ${tofi-drun} --drun-launch=true --prompt-text \"Launch: \"";
        "${modifier}+w" = "kill";
        "${modifier}+BracketLeft" = "workspace prev";
        "${modifier}+BracketRight" = "workspace next";
        # reload the configuration file
        "${modifier}+Shift+c" = "reload";
        "${modifier}+m" = "exec ${lock}";

        ### Manage windows

        ## Basics
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+v" = "floating toggle";
        "${modifier}+p" = "sticky toggle";
        "${modifier}+y" = "layout toggle split";
        "${modifier}+o" = "workspace back_and_forth";
        "${modifier}+c" = "move position center";

        ## Focus windows
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        ## Move windows
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";

        ## Scratchpad
        # Sway has a "scratchpad", which is a bag of holding for windows.
        # You can send windows there and get them back later.
        # Move the currently focused window to the scratchpad
        "${modifier}+Shift+u" = "move scratchpad";
        # Show the next scratchpad window or hide the focused scratchpad window.
        # If there are multiple scratchpad windows, this command cycles through them.
        "${modifier}+u" = "scratchpad show";

        "${modifier}+s" = "exec ${grim} -g \"$(${slurp})\" - | wl-copy -t image/png";
        "${modifier}+Semicolon" = "exec ${pass-tofi}";

        ## Modes
        "${modifier}+Shift+m" = ''mode "${system}"'';
        "${modifier}+r" = "mode resize";
      };

      window = {
        commands = [
          {
            criteria = {app_id = "gcr-prompter";};
            # Hacky way to disable the fullscreen when pinentry triggered
            command = "fullscreen toggle, fullscreen toggle";
          }
        ];
      };

      modes = {
        # set $system (l) lock, (e) logout, (s) shutdown
        "${system}" = {
          l = "exec ${lock}, mode default";
          e = "exec 'swaymsg exit; systemctl --user stop sway-session.target'"; # exit
          # s = "exec --no-startup-id systemctl suspend, mode default";
          s = "exec shutdown now";
          # return to default mode
          Return = "mode default";
          Escape = "mode default";
        };

        resize = {
          # up will shrink the containers height
          # down will grow the containers height
          # left will shrink the containers width
          # right will grow the containers width
          "k" = "resize shrink height 10px";
          "j" = "resize grow height 10px";
          "h" = "resize shrink width 10px";
          "l" = "resize grow width 10px";
          Return = "mode default";
          Escape = "mode default";
        };
      };
      menu = "exec ${tofi-drun} --drun-launch=true --prompt-text \"Launch: \"";

      startup = [
        {
          # Sleep after 15 minutes of inactivity
          # Turn off display after 20 minutes of inactivity
          command = ''
            ${swayidle} -w \
              timeout 900 '${lock}' \
              timeout 1200 'swaymsg "output * dpms off"' \
                resume 'swaymsg "output * dpms on"' \
              before-sleep '${lock}'
          '';
        }
      ];
    };

    extraConfig = ''
      bindswitch --reload --locked lid:on exec ${lock}
      exec ${wlsunset} -t 3000 -T 6500 -l 51.1 -L -114.1
    '';
  };
}
