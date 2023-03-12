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
    ./lf.nix
    ./bat.nix
    ./gitui.nix
    ./git.nix
  ];
}
