{
  description = "My NixOS config!!";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprland (https://wiki.hyprland.org/Nix/Hyprland-on-NixOS/)
    hyprland.url = "github:hyprwm/Hyprland";


    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
    in
    {
      # see https://m7.rs/git/nix-config/tree/modules 
      # for when i want to configure these
      # nixosModules = import ./modules/nixos;
      # homeManagerModules = import ./modules/home-manager;


      nixosConfigurations = {
        # Desktop
        nzxt = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/nzxt ];
        };

        # Thinkpad
        thinkpad = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/thinkpad ];
        };
      };

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
    };
}
