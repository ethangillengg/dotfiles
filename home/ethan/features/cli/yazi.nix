{
  pkgs,
  config,
  ...
}: let
  # Dependencies
  nvim = "${pkgs.neovim}/bin/nvim";
  #unpack .zip, .tar, .rar with one command
  unar = "${pkgs.ouch}/bin/ouch";
in {
  programs.yazi = {
    enable = true;
    settings = {
      manager.linemode = "permissions";
      opener = {
        "archive" = [
          {
            run = "${unar} \"$1\"";
          }
        ];
        "text" = [
          {
            run = "nvim \"$@\"";
            block = true;
          }
        ];
      };
    };
  };

  home.shellAliases = {
    # "lf" = "yazi";
    "y" = "yazi";
  };
}
