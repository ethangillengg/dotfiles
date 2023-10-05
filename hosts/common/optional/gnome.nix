{
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    desktopManager.gnome.enable = true;
  };
}
