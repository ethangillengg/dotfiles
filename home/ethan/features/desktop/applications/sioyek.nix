{
  config,
  lib,
  ...
}: let
  inherit (config.colorscheme) colors;
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

      ## Default colors
      background_color = "#${colors.base01}";
      text_highlight_color = "#${colors.base0A}";
      search_highlight_color = "#${colors.base0D}";
      status_bar_color = "#${colors.base02}";
      status_bar_text_color = "#${colors.base04}";
      link_highlight_color = "#${colors.base0D}";
      ## Themed colors
      custom_background_color = "#${colors.base01}";
      custom_text_color = "#${colors.base04}";
    };
  };
}
