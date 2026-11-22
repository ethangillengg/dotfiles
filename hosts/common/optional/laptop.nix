{
  services.upower = {
    enable = true;
  };
  # programs.light and programs.adb were removed from nixpkgs (unmaintained
  # upstream / handled by systemd 258 automatically). brightnessctl is used
  # directly for brightness control; add pkgs.android-tools if adb is needed.
  programs = {
    dconf.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };
}
