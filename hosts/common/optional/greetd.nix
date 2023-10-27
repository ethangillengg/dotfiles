{
  pkgs,
  lib,
  ...
}: let
  user = "ethan";
  gtkgreet = "${pkgs.greetd.gtkgreet}/bin/gtkgreet";

  sway-kiosk = command: "${pkgs.sway}/bin/sway --config ${pkgs.writeText "kiosk.config" ''
    output * bg #000000 solid_color
    exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK
    exec "${command}; ${pkgs.sway}/bin/swaymsg exit"
  ''}";
in {
  programs.sway.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = sway-kiosk "${gtkgreet} -l";
        # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        inherit user;
      };
    };
  };

  services. xserver.displayManager = {
    sddm.enable = lib.mkForce false;
    lightdm.enable = lib.mkForce false;
    gdm.enable = lib.mkForce false;
  };
  environment.etc."greetd/environments".text = ''
    sway
    Hyprland
  '';
}
