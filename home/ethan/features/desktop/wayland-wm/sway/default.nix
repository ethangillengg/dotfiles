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
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  terminal = config.home.sessionVariables.TERMINAL;
  wallpaper = config.wallpaper;
  swaymsg = "${pkgs.sway}/bin/swaymsg";

  inherit (config.colorscheme) colors;
in {
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      input = {
        "*" = {
          repeat_rate = "35";
          repeat_delay = "250";
        };
      };

      output = {
        "*" = {
          background = "${wallpaper} fit";
        };
      };

      keybindings = {
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Space" = "exec ${tofi-drun} --drun-launch=true --prompt-text \"Launch: \"";
        "${modifier}+Shift+M" = "exec ${swaymsg} exit";

        "${modifier}+Tab" = "workspace prev";
        "${modifier}+Shift+Tab" = "workspace next";
        "${modifier}+BracketLeft" = "workspace prev";
        "${modifier}+BracketRight" = "workspace next";
        "${modifier}+w" = "kill";
        "${modifier}+m" = "exec ${swaylock} -S --clock";
        "${modifier}+s" = "exec ${grim} -g \"$(${slurp})\" - | wl-copy -t image/png";

        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+v" = "floating toggle";
        "${modifier}+r" = "layout toggle split";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

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

        "${modifier}+Semicolon" = "exec ${pass-tofi}";
        "XF86MonBrightnessUp" = "exec,${brightnessctl} set 5%-";
        "XF86MonBrightnessDown" = "exec ${brightnessctl} set +5%";
        "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
      };
      menu = "exec ${tofi-drun} --drun-launch=true --prompt-text \"Launch: \"";
    };
  };
}
