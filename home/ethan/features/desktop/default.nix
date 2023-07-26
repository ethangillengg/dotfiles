{pkgs, ...}: {
  imports = [
    ./kitty.nix
    ./wezterm.nix
    ./feh.nix
    ./wofi.nix
    ./wayland-wm
    ./mpv.nix

    ./common/qt.nix
    ./common/gtk.nix
  ];

  home.packages = with pkgs; [
    gimp
  ];
}
