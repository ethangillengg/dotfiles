{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = [pkgs.wezterm];
    sessionVariables = {
      TERMINAL = "wezterm";
    };
  };
  programs.wezterm = {
    enable = true;
    # color_scheme = "Gruvbox dark, medium (base16)",
    # color_scheme = "Material Darker (base16)",
    extraConfig = ''
      return {
        font_size = 16.0,
        color_scheme = "Catppuccin Mocha",
        font = wezterm.font("${config.fontProfiles.monospace.family}"),
        hide_tab_bar_if_only_one_tab = true,
        enable_tab_bar = false,
        window_close_confirmation = "NeverPrompt",
        hide_mouse_cursor_when_typing = false,
        window_close_confirmation = "NeverPrompt",
        initial_cols = 120,
        initial_rows = 32,
        cursor_blink_rate = 0
      }
    '';
  };
}
