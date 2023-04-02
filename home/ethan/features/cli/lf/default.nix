{
  imports = [ ../trashy.nix ];
  programs.lf = {
    enable = true;

    commands = {

      "mkdir" = "%mkdir \"$@\"";
      "touch" = "%touch \"$@\"";

      "open" = "nvim $fx";

      # ''
      #   ''${{
      #       case ''$(file --mime-type -Lb $f) in
      #           text/*) nvim $fx;;
      #           *) for f in $fx; do setsid mimeopen $f > /dev/null 2> /dev/null & done;;
      #       esac
      #   }}
      # '';

      "trash" = "%trash put $fx";
    };

    keybindings = {
      "<enter>" = ":open";

      "<esc>" = ":setfilter";
      "f" = ":filter";
      "A" = "push :mkdir<space>";
      "a" = "push :touch<space>";

      "H" = ":set hidden!";

      "<delete>" = "trash";
    };

    extraConfig = ''
      set drawbox
      set ratios 2:5:5
      set info size
      set incfilter
      set incsearch
      set scrolloff 10 # leave some space at the top and the bottom of the screen
    '';
    cmdKeybindings = { };
    settings = {
      drawbox = true;
      icons = true;
    };
  };

  xdg.configFile."lf/icons".source = ./icons;
  xdg.configFile."lf/colors".source = ./colors;
}

