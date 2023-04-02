{ pkgs, ... }:
{
  imports = [
    ./aliases.nix
    ./bash.nix
    ./zoxide.nix
    ./fish.nix
    ./starship.nix
    ./exa.nix
    ./lsd.nix
    ./lf
    ./bat.nix
    ./gitui.nix
    ./git.nix
    ./bottom.nix
  ];
}
