{
  programs.feh = {
    enable = true;
    keybindings = {
      menu_parent = [
        "h"
        "Left"
      ];
      menu_child = [
        "l"
        "Right"
      ];
      menu_down = [
        "j"
        "Down"
      ];
      menu_up = [
        "k"
        "Up"
      ];
      menu_select = [
        "space"
        "Return"
      ];

      # Same for image navigation ...
      next_img = [
        "C-j"
        "n"
        "space"
      ];
      prev_img = [
        "C-k"
        "p"
        "BackSpace"
      ];

      # and image movement
      scroll_up = [
        "k"
        "Up"
        "s"
      ];
      scroll_down = [
        "j"
        "Down"
        "w"
      ];
      scroll_left = [
        "h"
        "Left"
        "d"
      ];
      scroll_right = [
        "l"
        "Right"
        "a"
      ];
      # zooming
      zoom_in = [
        "W"
        "C-Up"
        "K"
      ];

      zoom_out = [
        "S"
        "J"
        "C-Down"
      ];
      toggle_aliasing = "r";
      # I only hit these accidentally
      save_image = [];
      save_filelist = [];
    };
    buttons = {
      zoom_in = [4 1];
      zoom_out = 5;
      next_img = 3;
    };
  };
}
