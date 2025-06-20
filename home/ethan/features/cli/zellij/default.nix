{
  xdg.configFile."zellij/config.kdl" = {
    source = ./config.kdl;
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      pane_frames = false;
      mouse_mode = false;
      theme = "gruvbox-dark";
      default_mode = "locked";
    };
  };
}
