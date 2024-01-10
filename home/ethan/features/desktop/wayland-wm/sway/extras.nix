{pkgs, ...}: let
  # swayosd = "${pkgs.swayosd}/bin/swayosd";
  light = "${pkgs.light}/bin/light";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
in {
  # On-screen notifications for media controls (eg. brightness, volume, etc.)
  # services.swayosd = {
  #   enable = true;
  #   maxVolume = 125;
  # };
  wayland.windowManager.sway.config.keybindings = {
    # TODO: Wait for upstream fix of swayosd-libinput-backend service for NixOS
    ## Media Controls
    # "XF86MonBrightnessUp" = "exec ${swayosd} --brightness +5";
    # "XF86MonBrightnessDown" = "exec ${swayosd} --brightness -5";

    # "XF86AudioRaiseVolume" = "exec ${swayosd} --output-volume +5";
    # "XF86AudioLowerVolume" = "exec ${swayosd} --output-volume -5";
    # "XF86AudioMute" = "exec ${swayosd} --output-volume mute-toggle";
    # "XF86AudioMicMute" = "exec ${swayosd} --input-volume mute-toggle";

    ## Notify Pressed
    # "Caps_Lock" = "exec ${swayosd} --caps-lock";

    "XF86AudioRaiseVolume" = "exec ${pamixer} -i 5";
    "XF86AudioLowerVolume" = "exec ${pamixer} -d 5";
    "XF86AudioMute" = "exec ${pamixer} -t";
    "XF86AudioMicMute" = "exec ${pamixer} --default-source -t";

    "XF86MonBrightnessUp" = "exec ${light} -A 5%";
    "XF86MonBrightnessDown" = "exec ${light} -U 5%";
  };
}
