{pkgs, ...}: {
  imports = [
    ./zsh.nix
    ./fish.nix

    ./mods.nix
    ./aliases.nix
    ./bash.nix
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
    ./gpg
    ./aichat.nix
  ];
  home.packages = with pkgs; [
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

    # ai
    # nix-inspect # See which pkgs are in your PATH
  ];
}
