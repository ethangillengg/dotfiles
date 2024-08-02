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
  colorscheme = inputs.nix-colors.colorschemes.catppuccin-mocha;
  wallpaper = outputs.wallpapers.forest-spring;
}
