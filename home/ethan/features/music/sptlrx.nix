{pkgs, ...}: let
  formats = with pkgs.formats; {
    yaml = yaml {};
  };
in {
  home.packages = with pkgs; [
    sptlrx
  ];

  xdg.configFile."sptlrx/config.yaml".source = formats.yaml.generate "sptlrx-config" {
    player = "mpris";
    # lyrics styles
    style = {
      before = {
        italic = true;
        faint = true;
      };
      current = {
        # typo in the source code
        underline = true;
        bold = true;
      };
    };
  };
}
