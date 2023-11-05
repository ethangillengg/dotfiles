{pkgs, ...}: let
  swayosd = "${pkgs.swayosd}/bin/swayosd";
in {
  # On-screen notifications for media controls (eg. brightness, volume, etc.)
  services.swayosd = {
    enable = true;
    maxVolume = 125;
  };
  wayland.windowManager.sway.config.keybindings = {
    ## Media Controls
    "XF86MonBrightnessUp" = "exec ${swayosd} --brightness +5";
    "XF86MonBrightnessDown" = "exec ${swayosd} --brightness -5";
    "XF86AudioRaiseVolume" = "exec ${swayosd} --output-volume +5";
    "XF86AudioLowerVolume" = "exec ${swayosd} --output-volume -5";
    "XF86AudioMute" = "exec ${swayosd} --output-volume mute-toggle";
    "XF86AudioMicMute" = "exec ${swayosd} --input-volume mute-toggle";

    ## Notify Pressed
    "Caps_Lock" = "exec ${swayosd} --caps-lock";
  };
}
