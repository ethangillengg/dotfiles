{
  pkgs,
  config,
  ...
}: let
  inherit (config.colorscheme) colors;
in {
  home.packages = [pkgs.tofi];
  home.file.".config/tofi/config".text = ''
    font = "${config.fontProfiles.regular.family}"
    text-cursor = true
    border-color = "#${colors.base0C}"
    text-color = "#${colors.base05}"
    selection-color = "#${colors.base0C}"

    ## Windowed Theme
    # background-color = "#${colors.base00}"
    # outline-width = 0
    # border-width = 3
    # corner-radius = 2
    # width = 25%

    ## Fullscreen Theme
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 35%
    padding-top = 10%
    result-spacing = 15
    num-results = 20
    background-color = #000A
  '';
}
