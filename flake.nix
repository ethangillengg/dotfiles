{
  description = "NixOS and Home Manager configuration for my personal devices";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secret management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh = {
      url = "github:viperml/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    object-viewer = {
      url = "git+ssh://git@github.com/ethangillengg/CPSC453/?submodules=1&ref=02-Object-Viewer";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ripgrep-all = {
      url = "github:phiresky/ripgrep-all";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    lib = nixpkgs.lib // home-manager.lib;
    systems = ["x86_64-linux" "aarch64-linux"];
    forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
    pkgsFor = nixpkgs.legacyPackages;

    mkNixos = modules:
      nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = {inherit inputs outputs;};
      };

    mkHome = modules: pkgs:
      home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = {inherit inputs outputs;};
      };
  in {
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;
    # templates = import ./templates;

    overlays = import ./overlays {inherit inputs outputs;};
    # hydraJobs = import ./hydra.nix {inherit inputs outputs;};

    packages = forEachSystem (pkgs: import ./pkgs {inherit pkgs;});
    devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

    wallpapers = import ./home/ethan/wallpapers;

    nixosConfigurations = {
      thinkpad = mkNixos [./hosts/thinkpad];
      nzxt = mkNixos [./hosts/nzxt]; # Server
    };

    homeConfigurations = {
      "ethan@thinkpad" = mkHome [./home/ethan/thinkpad.nix] nixpkgs.legacyPackages."x86_64-linux"; # Laptop
      "ethan@nzxt" = mkHome [./home/ethan/nzxt.nix] nixpkgs.legacyPackages."x86_64-linux"; # Server
    };
  };
}
