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

  home.packages = with pkgs; [
    firefox
    neovim
    osu-lazer
    youtube-music
    discord
    webcord
    ripgrep
    cargo
    btop
    nvtop
    nerdfonts
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

