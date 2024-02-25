{pkgs, ...}: let
  swayosd-client = "${pkgs.swayosd}/bin/swayosd-client";
in {
  # On-screen notifications for media controls (eg. brightness, volume, etc.)
  services.swayosd = {
    enable = true;
  };
  home.packages = with pkgs; [
    swayosd
  ];

  wayland.windowManager.sway = {
    config.keybindings = {
      ## Brightness
      "XF86MonBrightnessUp" = "exec ${swayosd-client} --brightness +5";
      "XF86MonBrightnessDown" = "exec ${swayosd-client} --brightness -5";

      ## Volume
      "XF86AudioRaiseVolume" = "exec ${swayosd-client} --output-volume +5";
      "XF86AudioLowerVolume" = "exec ${swayosd-client} --output-volume -5";
      "XF86AudioMute" = "exec ${swayosd-client} --output-volume mute-toggle";
      "XF86AudioMicMute" = "exec ${swayosd-client} --input-volume mute-toggle";
    };
    ## Caps Lock
    extraConfig = ''
      bindsym --release Caps_Lock exec ${swayosd-client} --caps-lock
    '';
  };
}
