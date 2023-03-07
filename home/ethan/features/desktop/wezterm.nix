{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Ayu Mirage",
      }
    '';
  };
}
