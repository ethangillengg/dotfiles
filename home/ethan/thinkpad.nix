{ inputs, pkgs, ... }: {
  imports = [
    ./global
    ./features/cli
    ./features/desktop
    ./features/coding
    # ./features/desktop/hyprland
    # ./features/desktop/wireless
    # ./features/productivity
    # ./features/pass
    # ./features/games
  ];

  # wallpaper = (import ./wallpapers).aenami-lunar;
  # colorscheme = inputs.nix-colors.colorschemes.paraiso;

  # monitors = [{
  #   name = "eDP-1";
  #   width = 1920;
  #   height = 1080;
  #   hasBar = true;
  #   workspace = "1";
  # }];
}

