{
  description = "NixOS and Home Manager configuration for my personal devices";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland"; # Hyprland (https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/)
    # sops-nix.url = "github:mic92/sops-nix"; # Secret management

    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
    forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});

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
    nixpkgs.overlays = [inputs.self-overlay.overlays.additions];
    overlays = import ./overlays {inherit inputs outputs;};

    packages = forEachPkgs (pkgs: (import ./pkgs {inherit pkgs;}));
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      thinkpad = mkNixos [./hosts/thinkpad]; # Laptop
      nzxt = mkNixos [./hosts/nzxt]; # Server
    };

    homeConfigurations = {
      "ethan@thinkpad" = mkHome [./home/ethan/thinkpad.nix] nixpkgs.legacyPackages."x86_64-linux"; # Laptop
      "ethan@nzxt" = mkHome [./home/ethan/nzxt.nix] nixpkgs.legacyPackages."x86_64-linux"; # Server
    };
  };
}
