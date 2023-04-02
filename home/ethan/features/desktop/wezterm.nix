{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Ayu Mirage",
        hide_cursor_when_typing = false,
        enable_tab_bar = false,
        font_size = 14.0,
        window_close_confirmation = "NeverPrompt",
        skip_close_confirmation_for_processes_named = {
          'bash',
          'fish',
        },
        initial_cols = 120,
        initial_rows = 32
      }
    '';
  };
}
