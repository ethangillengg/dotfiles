{lib, ...}: {
  xdg.configFile."zellij/config.kdl" = {
    source = ./config.kdl;
  };

  # home.sessionVariables.ZELLIJ_AUTO_ATTACH = lib.mkForce "false";
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
}
