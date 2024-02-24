{
  pkgs,
  config,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  home.packages = [pkgs.tofi];
  home.file.".config/tofi/config".text = ''
    font = "${config.fontProfiles.regular.family}"
    text-cursor = true
    border-color = "#${palette.base0C}"
    text-color = "#${palette.base05}"
    selection-color = "#${palette.base0C}"

    ## Windowed Theme
    # background-color = "#${palette.base00}"
    # outline-width = 0
    # border-width = 3
    # corner-radius = 2
    # width = 25%

    ## Fullscreen Theme
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 25%
    padding-top = 10%
    result-spacing = 15
    num-results = 20
    background-color = #000A
  '';
}
