{config, ...}: let
  inherit (config.colorscheme) colors kind;
in {
  services.mako = {
    enable = true;
    iconPath =
      if kind == "dark"
      then "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark"
      else "${config.gtk.iconTheme.package}/share/icons/Papirus-Light";
    font = "${config.fontProfiles.regular.family} 12";
    padding = "10,15";
    anchor = "top-right";
    width = 450;
    height = 200;
    borderSize = 2;
    defaultTimeout = 8000;
    backgroundColor = "#${colors.base00}dd";
    borderColor = "#${colors.base03}dd";
    textColor = "#${colors.base05}dd";
    extraConfig = ''
      [mode=do-not-disturb]
      invisible=1
    '';
  };
}
