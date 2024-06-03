{
  config,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  home = {
    packages = [pkgs.foot];
    sessionVariables = {
      TERMINAL = "foot";
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        # term = "xterm-256-color";
        font = "${config.fontProfiles.monospace.family}:size=16";
        dpi-aware = "yes";
        pad = "16x16";
        # line-height = 16;
      };
      mouse = {
        hide-when-typing = "yes";
      };
      cursor = {
        blink = "no";
        color = "${palette.base00} ${palette.base07}";
      };
      scrollback = {
        lines = 100000;
      };

      colors = {
        foreground = palette.base05;
        background = palette.base00;
        regular0 = palette.base00;
        regular1 = palette.base08;
        regular2 = palette.base0B;
        regular3 = palette.base0A;
        regular4 = palette.base0D;
        regular5 = palette.base0E;
        regular6 = palette.base0C;
        regular7 = palette.base05;
        bright0 = palette.base03;
        bright1 = palette.base08;
        bright2 = palette.base0B;
        bright3 = palette.base0A;
        bright4 = palette.base0D;
        bright5 = palette.base0E;
        bright6 = palette.base0C;
        bright7 = palette.base07;
      };
    };
  };
}
