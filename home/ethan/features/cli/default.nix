{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./lf

    ./zsh.nix
    ./fish.nix

    ./aliases.nix
    ./bash.nix
    ./zoxide.nix
    ./starship.nix
    ./lsd.nix
    ./yazi.nix
    ./bat.nix
    ./git.nix
    ./bottom.nix
    ./fzf.nix
    ./gpg.nix
    ./manix.nix
    ./chatgpt.nix
  ];
  home.packages = with pkgs; [
    # comma # Install and run programs by sticking a , before them
    # distrobox # Nice escape hatch, integrates docker images with my environment

    # bc # Calculator
    # ncdu # TUI disk usage
    # eza # Better ls
    # ripgrep # Better grep
    # fd # Better find
    # httpie # Better curl
    # diffsitter # Better diff
    # jq # JSON pretty printer and manipulator
    # trekscii # Cute startrek cli printer

    timer # To help with my ADHD paralysis
    nerdfix # fix nerd fonts
    nix-melt # analyze nix flake inputs/outputs
    kalker # cli calculator
    pdfgrep # grep pdfs
    ytfzf # youtube cli

    # nil # Nix LSP
    # nixfmt # Nix formatter
    # nix-inspect # See which pkgs are in your PATH
    #
    # ltex-ls # Spell checking LSP

    # tly # Tally counter
    inputs.nh.packages."x86_64-linux".default
    # inputs.nh.default # nixos-rebuild and home-manager CLI wrapper
  ];
}
