{config, ...}: let
  inherit (config.colorscheme) variant palette;
in {
  services.mako = {
    enable = true;
    settings = {
      iconPath =
        if variant == "dark"
        then "${config.gtk.iconTheme.package}/share/icons/Papirus-Dark"
        else "${config.gtk.iconTheme.package}/share/icons/Papirus-Light";
      font = "${config.fontProfiles.regular.family} 12";
      padding = "10,15";
      anchor = "top-right";
      width = 450;
      height = 200;
      borderSize = 2;
      defaultTimeout = 8000;
      groupBy = "app-name";
      backgroundColor = "#${palette.base00}dd";
      borderColor = "#${palette.base03}dd";
      textColor = "#${palette.base05}dd";
      extraConfig = ''
        [mode=do-not-disturb]
        invisible=1
      '';
    };
  };
}
