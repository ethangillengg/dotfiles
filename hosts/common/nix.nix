{
  lib,
  inputs,
  ...
}: {
  nix = {
    settings = {
      # substituters = [
      #   # "https://nix-community.cachix.org"
      #   # "https://cache.nixos.org/"
      #   "http://nzxt.emerald-duck.ts.net:9999"
      # ];
      # trusted-public-keys = [
      #   # "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg="
      #   # "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      #   "nzxt.emerald-duck.ts.net:9999:/PdhmEUvwHUTtTSduPyVpscte/oPlrzAT9eARJDartw="
      # ];
      #
      auto-optimise-store = lib.mkDefault true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      # Keep the last 3 generations
      options = "--delete-older-than +3";
    };

    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    nixPath = ["nixpkgs=${inputs.nixpkgs.outPath}"];
  };
  nixpkgs.config.allowUnfree = true;
}
