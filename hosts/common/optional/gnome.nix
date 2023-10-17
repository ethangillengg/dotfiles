{pkgs, ...}: {
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";
    displayManager.gdm = {
      enable = false;
    };
    desktopManager.gnome.enable = true;
  };
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-wlr
  ];
}
