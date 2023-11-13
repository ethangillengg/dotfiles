{
  outputs,
  inputs,
  ...
}: {
  imports = [
    ./global
    ./features/desktop
    ./features/coding
    ./features/pass
    ./features/productivity
    ./features/music
    ./features/japanese
  ];

  #Favs:
  # colorscheme = inputs.nix-colors.colorschemes.material-darker;
  # colorscheme = inputs.nix-colors.colorschemes.catppuccin-macchiato;
  colorscheme = inputs.nix-colors.colorschemes.catppuccin-mocha;
  # colorscheme = inputs.nix-colors.colorschemes.material-palenight;
  # colorscheme = inputs.nix-colors.colorschemes.nord;
  # colorscheme = inputs.nix-colors.colorschemes.rose-pine;
  # colorscheme = inputs.nix-colors.colorschemes.rose-pine-moon;
  # colorscheme = inputs.nix-colors.colorschemes.gruvbox-material-dark-hard;

  # wallpaper = outputs.wallpapers.gruvbox-pacman;
  wallpaper = outputs.wallpapers.catppuccin-astro;

  # monitors = [{
  #   name = "eDP-1";
  #   width = 1920;
  #   height = 1080;
  #   hasBar = true;
  #   workspace = "1";
  # }];
}
