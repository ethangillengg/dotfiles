{
  outputs,
  inputs,
  ...
}: {
  imports = [
    ./global
    ./features/coding
    ./features/pass
    ./features/productivity
  ];

  #Favs:
  colorscheme = inputs.nix-colors.colorschemes.gruvbox-material-dark-hard;
  wallpaper = outputs.wallpapers.forest-spring;
}
