{pkgs, ...}: let
  formats = with pkgs.formats; {
    yaml = yaml {};
  };
in {
  home.packages = with pkgs; [
    sptlrx
  ];

  xdg.configFile."sptlrx/config.yaml".source = formats.yaml.generate "sptlrx-config" {
    player = "mpd";
    mpd = {
      address = "127.0.0.1:6600";
      password = "";
    };
    # lyrics styles
    style = {
      before = {
        italic = true;
        faint = true;
      };
      current = {
        # typo in the source code
        undeline = true;
        bold = true;
      };
    };
  };
}
