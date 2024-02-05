{pkgs, ...}: {
  imports = [
    ./mpd
    ./cava
    ./ncmp
    ./sptlrx.nix
  ];

  home.packages = with pkgs; [
    picard
    sonixd
  ];
}
