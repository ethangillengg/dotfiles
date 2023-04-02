{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Ayu Mirage",
        hide_cursor_when_typing = false,
        enable_tab_bar = false,
        font_size = 12.0,
        initial_cols = 120,
        initial_rows = 32
      }
    '';
  };
}
