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
      pname = "homework";
      name = pname;

      watcher = pkgs.writeScriptBin "watch" ''
        out=".latexmkout"
        mkdir "$out"
        latexmk \
          -pvc \
          -outdir="$out" \
          -pdf \
          -pdflatex="pdflatex -interaction=nonstopmode" \
          -use-make ${pname}.tex
        rm -r "$out"
      '';

      buildLatex = pkgs.stdenv.mkDerivation {
        inherit pname;

        src = ./.;

        nativeBuildInputs = with pkgs; [
          (texlive.combine {
            inherit
              (texlive)
              scheme-medium
              multirow
              hyperref
              blindtext
              fancyhdr
              etoolbox
              topiclongtable
              ;
          })
          gnumake
        ];

        buildPhase = ''
          latexmk \
          -pdf \
          -pdflatex="pdflatex -interaction=nonstopmode" \
          -use-make ${pname}.tex
        '';
        installPhase = ''
          install -Dm444 -t $out ${pname}.pdf
        '';
      };
    in {
      packages.${pname} = pkgs.stdenv.mkDerivation {
        inherit watcher buildLatex name;
      };

      # defaultPackage = packages.virtual-orrery;
      devShell = pkgs.mkShell {
        nativeBuildInputs = [pkgs.bashInteractive];
        buildInputs = with pkgs; [
          rubber
          texlab
          texliveFull
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
