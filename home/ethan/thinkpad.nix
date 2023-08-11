{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (inputs.nix-colors) colorSchemes;
  inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) colorschemeFromPicture nixWallpaperFromScheme;
in {
  imports = [
    ./global
    ./features/cli
    ./features/desktop
    ./features/coding
    # ./wallpapers
  ];

  #Favs:
  colorscheme = inputs.nix-colors.colorschemes.material-darker;
  # colorscheme = inputs.nix-colors.colorschemes.gruvbox-material-dark-hard;
  # colorscheme = inputs.nix-colors.colorschemes.catppuccin-macchiato;
  # colorscheme = inputs.nix-colors.colorschemes.catppuccin-mocha;
  # colorscheme = inputs.nix-colors.colorschemes.material-palenight;
  # colorscheme = inputs.nix-colors.colorschemes.nord;
  # colorscheme = inputs.nix-colors.colorschemes.rose-pine;
  # colorscheme = inputs.nix-colors.colorschemes.rose-pine-moon;

  wallpaper = ./wallpapers/animegirlwithdog.jpg;
  # wallpaper = let
  #   largest = f: xs: builtins.head (builtins.sort (a: b: a > b) (map f xs));
  #   # largestWidth = largest (x: x.width) config.monitors;
  #   # largestHeight = largest (x: x.height) config.monitors;
  # in
  #   lib.mkDefault (nixWallpaperFromScheme
  #     {
  #       scheme = config.colorscheme;
  #       width = 2560;
  #       height = 1440;
  #       logoScale = 4;
  #     });
  home.file.".colorscheme".text = config.colorscheme.slug;

  # monitors = [{
  #   name = "eDP-1";
  #   width = 1920;
  #   height = 1080;
  #   hasBar = true;
  #   workspace = "1";
  # }];
}
