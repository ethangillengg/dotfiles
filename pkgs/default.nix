{ pkgs ? import <nixpkgs> { } }: {

  # Packages with an actual source
  wgnord-latest = pkgs.callPackage ./wgnord-latest { };
  shellcolord = pkgs.callPackage ./shellcolord { };

  # Personal scripts
  yt-music = pkgs.callPackage ./yt-music { };
}
