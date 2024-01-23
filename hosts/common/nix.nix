{
  lib,
  inputs,
  ...
}: {
  nix = {
    settings = {
      substituters = [
        # "https://nix-community.cachix.org"
        # "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        # "cache.m7.rs:kszZ/NSwE/TjhOcPPQ16IuUiuRSisdiIwhKZCxguaWg="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "nzxt.emerald-duck.ts.net:9999:7+2mxpoaF+NGTHZ7q2SnHxmmAfzc63pS41Scjxyz+gE="
        "nzxt.emerald-duck.ts.net:1kS1rqbwM+v6Smi3XiiV/SYcqNXM03taU3PbekrPL+U="
        # "nzxt.emerald-duck.ts.net:9999:1kS1rqbwM+v6Smi3XiiV/SYcqNXM03taU3PbekrPL+U="
        # "nzxt.emerald-duck.ts.net:1kS1rqbwM+v6Smi3XiiV/SYcqNXM03taU3PbekrPL+U="
        # "nzxt.emerald-duck.ts.net:7+2mxpoaF+NGTHZ7q2SnHxmmAfzc63pS41Scjxyz+gE="

        # "nzxt.emerald-duck.ts.net:VLHUz+n+brCRI57Dk45pmjMLAN2Iznpyxh2vVVrRaSc="
      ];

      auto-optimise-store = lib.mkDefault true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      flake-registry = ""; # Disable global flake registry
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
