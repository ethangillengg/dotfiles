{pkgs, ...}: {
  imports = [
    ./lf

    ./zsh.nix
    ./fish.nix

    ./aliases.nix
    ./bash.nix
    ./zoxide.nix
    ./ytfzf.nix
    ./starship.nix
    ./lsd.nix
    ./yazi.nix
    ./bat.nix
    ./git.nix
    ./gh.nix
    ./bottom.nix
    ./fzf.nix
    ./gpg.nix
    ./aichat.nix
    ./mods.nix
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
    # timer # To help with my ADHD paralysis

    porsmo # cli pomodoro, stopwatch and timer
    nerdfix # fix nerd fonts
    nix-melt # analyze nix flake inputs/outputs
    kalker # cli calculator
    pdfgrep # grep pdfs
    ouch # compress/decompress .zip, .tar, .rar with one command
    pandoc
    dig
    glow # pretty markdown
    tree

    # nil # Nix LSP
    # nixfmt # Nix formatter
    # nix-inspect # See which pkgs are in your PATH
    #
    # ltex-ls # Spell checking LSP

    # tly # Tally counter
  ];
}
