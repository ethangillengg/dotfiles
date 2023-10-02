{
  config,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  programs.rio = {
    enable = true;
    settings = {
      padding-x = 10;
      theme = "dracula";
      fonts = {
        family = "${config.fontProfiles.regular.family}";
        size = 18;
      };
      colors = {
        foreground = "#${colors.base05}";
        background = "#${colors.base00}";
        cursor = "#${colors.base05}";
      };
    };
  };
}
