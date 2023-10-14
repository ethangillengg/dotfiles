{
  config,
  pkgs,
  ...
}: {
  # copy whole directory to ~/.config/eww
  xdg.configFile."eww" = {
    source = ./config;
    recursive = true;
  };

  home.packages = with pkgs; [
    libnotify # send notifications
    brightnessctl
  ];

  # home = {
  #   activation = {
  #     installConfig = ''
  #       if [ ! -d "${config.home.homeDirectory}/.config/eww" ]; then
  #         ${pkgs.git}/bin/git clone --depth 1 --branch eww https://github.com/chadcat7/crystal ${config.home.homeDirectory}/.config/eww
  #       fi
  #     '';
  #   };
  # };
}
