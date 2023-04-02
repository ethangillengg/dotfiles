{
  programs.lf = {
    enable = true;

    commands = {

      "mkdir" = "%mkdir \"$@\"";
      "touch" = "%touch \"$@\"";
    };

    keybindings = {
      "<enter>" = ":open";

      "<esc>" = ":setfilter";
      "f" = ":filter";
      "A" = "push :mkdir<space>";
      "a" = "push :touch<space>";

      # map A push :mkdir<space>
      # map a push :touch<space>
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
