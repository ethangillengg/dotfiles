{
  config,
  lib,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  programs.sioyek = {
    enable = true;
    bindings = {
      "move_up" = "k";
      "move_down" = "j";
      "move_right" = "h";
      "move_left" = "l";
      "screen_down" = ["d" "<C-d>"];
      "screen_up" = ["u" "<C-u>"];
      "fit_to_page_width_ratio" = "s";
      "fit_to_page_width_smart" = "S";

      "next_page" = ["<C-j>" "J"];
      "previous_page" = ["<C-k>" "K"];
      "toggle_custom_color" = "<C-r>";
      "goto_toc" = "<tab>";
    };
    config = rec {
      ## Font
      ui_font = "${config.fontProfiles.regular.family}";
      font_size = "20";
      status_bar_font_size = font_size;
      page_separator_width = "2";
      should_launch_new_window = "1";

      ## Default colors
      background_color = "#${palette.base01}";
      page_separator_color = "#${palette.base01}";
      text_highlight_color = "#${palette.base0A}";
      search_highlight_color = "#${palette.base0D}";
      status_bar_color = "#${palette.base02}";
      status_bar_text_color = "#${palette.base04}";
      link_highlight_color = "#${palette.base0D}";
      ## Themed colors
      custom_background_color = "#${palette.base01}";
      custom_text_color = "#${palette.base04}";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = ["sioyek"];
  };
}
