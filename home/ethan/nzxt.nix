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
}

