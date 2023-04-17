{ inputs, pkgs, ... }:
{

  home.packages = with pkgs; [
    gimp
  ];
  imports = [
    ./kitty.nix
    ./wezterm.nix
    ./feh.nix
    ./wofi.nix
    ./hyprland
  ];
}
