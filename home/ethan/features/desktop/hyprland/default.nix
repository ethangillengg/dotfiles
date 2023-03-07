{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./wezterm.nix
    ./hyprland
  ];
}
