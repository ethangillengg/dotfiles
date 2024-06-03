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
    # color_scheme = "Material Darker (base16)",
    # color_scheme = "Catppuccin Mocha",
    extraConfig = ''
      return {
        font_size = 16.0,
        color_scheme = "Gruvbox dark, medium (base16)",
        font = wezterm.font_with_fallback {
          "${config.fontProfiles.monospace.family}",
          "${config.fontProfiles.fallback.family}",
        },
        hide_tab_bar_if_only_one_tab = true,
        enable_tab_bar = false,
        enable_wayland = false,
        front_end = "OpenGL",
        window_close_confirmation = "NeverPrompt",
        cursor_blink_rate = 0
      }
    '';
  };
}
