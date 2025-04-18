{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) colorschemeFromPicture nixWallpaperFromScheme;
in {
  imports =
    [
      inputs.nix-colors.homeManagerModule
      ./../features/cli
      ./gnome.nix
      ./fonts.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  programs.home-manager.enable = true;

  home = {
    username = "ethan";
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "22.11"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    sessionPath = ["$HOME/.local/bin"];
    sessionVariables = {
      FLAKE = "$HOME/.dotfiles/";
      EDITOR = "${pkgs.neovim}/bin/nvim";
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };

  systemd.user.startServices = "sd-switch";

  colorscheme = lib.mkDefault colorSchemes.material-darker;
  wallpaper =
    # let
    #   largest = f: xs: builtins.head (builtins.sort (a: b: a > b) (map f xs));
    #   largestWidth = largest (x: x.width) config.monitors;
    #   largestHeight = largest (x: x.height) config.monitors;
    # in
    lib.mkDefault (nixWallpaperFromScheme
      {
        scheme = config.colorscheme;
        width = 2560;
        height = 1440;
        logoScale = 4;
      });
  home.file.".colorscheme".text = config.colorscheme.slug;
}
