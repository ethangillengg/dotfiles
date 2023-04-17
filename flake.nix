{
  description = "My NixOS config!!";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland"; # Hyprland (https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/)
    sops-nix.url = "github:mic92/sops-nix"; # Secret management

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # fingerprint sensor for thinkpad
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs:
    let
      inherit (self) outputs;
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
      forEachPkgs = f: forEachSystem (system: f nixpkgs.legacyPackages.${system}); # NO OVERLAYS
    in
    {
      # packages = forEachPkgs (pkgs: (import ./pkgs { inherit pkgs; }));
      # overlays = import ./overlays { inherit inputs outputs; };

      # see https://m7.rs/git/nix-config/tree/modules 
      # for when i want to configure these
      # nixosModules = import ./modules/nixos;
      # homeManagerModules = import ./modules/home-manager;

      homeConfigurations = {
        # Desktop
        "ethan@nzxt" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/ethan/nzxt.nix ];
        };

        # Thinkpad
        "ethan@thinkpad" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/ethan/thinkpad.nix ];
        };
      };

      nixosConfigurations = {
        # Desktop
        nzxt = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/nzxt ];
        };

        # Thinkpad
        thinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
            ./hosts/thinkpad
          ];
        };
      };
    };
}
