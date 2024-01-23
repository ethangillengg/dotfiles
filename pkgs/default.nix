{pkgs ? import <nixpkgs> {}}: {
  # Packages with an actual source
  wgnord-latest = pkgs.callPackage ./wgnord-latest {};
  shellcolord = pkgs.callPackage ./shellcolord {};

  # Personal scripts
  yt-music = pkgs.callPackage ./yt-music {};
  random-wallpaper = pkgs.callPackage ./random-wallpaper {};
  quote = pkgs.callPackage ./quote {};
  pass-tofi = pkgs.callPackage ./pass-tofi {};
  pomodoro-sh = pkgs.callPackage ./pomodoro-sh {};
  pdfsearch = pkgs.callPackage ./pdfsearch {};
}
