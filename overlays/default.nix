{ pkgs }:
{
  home.packages = with pkgs; [
    (
      lf.override {
        src = super.fetchFromGitHub {
          owner = "horriblename";
          repo = "lf";
          rev = "a30c2dd640e0edbe4b04e49f827be4381a331a3a";
          # If you don't know the hash, the first time, set:
          # hash = "";
          # then nix will fail the build with such an error message:
          # hash mismatch in fixed-output derivation '/nix/store/m1ga09c0z1a6n7rj8ky3s31dpgalsn0n-source':
          # specified: sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
          # got:    sha256-173gxk0ymiw94glyjzjizp8bv8g72gwkjhacigd1an09jshdrjb4
          hash = "sha256-i+CpXdvPyAMet2aZ3UQVtp30JKkx8otSXIJr3dP6BC4=";
        };
      })
  ];
}
