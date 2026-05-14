{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.arc-menu
    gnomeExtensions.forge
    gnomeExtensions.vicinae
    gnomeExtensions.user-themes
    vicinae
    xdg-desktop-portal-wlr
    rofi
    gtk-engine-murrine
    sassc
    gnome-themes-extra
    gruvbox-gtk-theme
    refine
  ];
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # services.xserver = {
  #   enable = true;
  #   xkb.layout = "us";
  #   xkb.variant = "";
  # };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
