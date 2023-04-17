{
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
}
