{pkgs, ...}: let
  cursorSize = 48;
in {
  wayland.windowManager.hyprland.extraConfig = ''
    env = HYPRCURSOR_THEME,rose-pine-hyprcursor
    env = HYPRCURSOR_SIZE,${toString cursorSize}
  '';

  gtk.cursorTheme = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = cursorSize;
  };
}
