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
  colorscheme = inputs.nix-colors.colorschemes.gruvbox-material-dark-hard;
  wallpaper = outputs.wallpapers.forest-spring;

  # monitors = [{
  #   name = "eDP-1";
  #   width = 1920;
  #   height = 1080;
  #   hasBar = true;
  #   workspace = "1";
  # }];
}
