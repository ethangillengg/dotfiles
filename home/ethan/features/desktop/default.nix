{pkgs, ...}: {
  imports = [
    ./rio.nix
    ./wezterm.nix
    ./feh.nix
    ./wofi.nix
    ./wayland-wm
    ./mpv.nix
    ./wpa-gui.nix

    ./common/qt.nix
    ./common/gtk.nix
  ];

  home.packages = with pkgs; [
    gimp
  ];
}
