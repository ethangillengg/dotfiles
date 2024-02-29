{pkgs ? import <nixpkgs> {}}: {
  # Packages with an actual source
  wgnord-latest = pkgs.callPackage ./wgnord-latest {};
  shellcolord = pkgs.callPackage ./shellcolord {};

  # Personal scripts
  random-wallpaper = pkgs.callPackage ./random-wallpaper {};
  quote = pkgs.callPackage ./quote {};
  pass-tofi = pkgs.callPackage ./pass-tofi {};
  pdfsearch = pkgs.callPackage ./pdfsearch {};
  ai = pkgs.callPackage ./ai {};
}
