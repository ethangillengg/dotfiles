{pkgs, ...}: {
  imports = [
    ./rio.nix
    ./wezterm.nix
    ./feh.nix
    ./rofi.nix
    ./mpv.nix
    ./wpa-gui.nix
    ./zathura.nix
    ./qutebrowser.nix
  ];
}
