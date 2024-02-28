{
  description = "LaTeX Homework Report Template";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        system = "x86_64-linux"; # or something else
        config = {allowUnfree = true;};
      };

      watcher = pkgs.writeScriptBin "watch" ''
        tectonic -X build
        nohup sioyek build/hw/hw.pdf >/dev/null 2>&1& tectonic -X watch
      '';
    in {
      devShell = pkgs.mkShell {
        nativeBuildInputs = [pkgs.bashInteractive];
        buildInputs = with pkgs; [
          texlab
          tectonic
        ];
      };

      apps = {
        watch = {
          type = "app";
          program = "${watcher}/bin/watch";
        };
      };
    });
}
