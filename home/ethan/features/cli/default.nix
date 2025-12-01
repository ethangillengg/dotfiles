{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./zsh.nix
    ./bash.nix
    ./aliases.nix

    ./zoxide.nix
    ./ytfzf.nix
    ./yt-dlp.nix
    ./lsd.nix
    ./yazi.nix
    ./bat.nix
    ./git.nix
    ./gh.nix
    ./bottom.nix
    ./fzf.nix
    ./trashy.nix
    ./gpg
  ];

  home.packages = with pkgs; [
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
    tomb
    porsmo # cli pomodoro, stopwatch and timer
    nerdfix # fix nerd fonts
    ouch # compress/decompress .zip, .tar, .rar with one command
    pandoc # document converter
    dig # dns
    glow # pretty markdown
    tree
    sqlite
    wl-mirror
    imagemagick # convert images on cli
    sqlcmd
    speedtest-go
    wgnord-latest
    s-tui # power and other bench not in btop
    stress # stress test cpu
    unoconv # convert .doc, .docx files
    geekbench
    neo-cowsay
    fortune
    aider-chat

    nix-inspect # See which pkgs are in your PATH
  ];
}
