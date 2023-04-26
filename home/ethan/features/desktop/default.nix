{ inputs, pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./wezterm.nix
    ./feh.nix
    ./wofi.nix
    ./wayland-wm

    ./common/qt.nix
    ./common/gtk.nix
  ];

  home.packages = with pkgs; [
    gimp
  ];
}
