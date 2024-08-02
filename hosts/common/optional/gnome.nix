{pkgs, ...}: {
  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.variant = "";
    displayManager.gdm = {
      enable = false;
    };
    desktopManager.gnome.enable = true;
  };
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-wlr
  ];
}
