{pkgs, ...}: {
  imports = [
    ./rio.nix
    ./wezterm.nix
    ./feh.nix
    ./rofi.nix
    ./wayland-wm
    ./mpv.nix
    ./wpa-gui.nix

    ./common/qt.nix
    ./common/gtk.nix
  ];
}
