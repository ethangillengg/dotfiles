{pkgs, ...}: let
  # Dependencies
  ouch = "${pkgs.ouch}/bin/ouch";
  ripdrag = "${pkgs.ripdrag}/bin/ripdrag";
in {
  home.packages = [
    pkgs.ripdrag
  ];

  home.shellAliases = {
    f = "yazi";
  };

  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        linemode = "permissions";
        keymap = [
          {
            exec = "shell '${ripdrag} -x -i -T \"$1\"' --confirm";
            on = ["<C-n>"];
          }
        ];
      };
      opener = {
        "archive" = [
          {
            run = "${ouch} \"$1\"";
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
}
