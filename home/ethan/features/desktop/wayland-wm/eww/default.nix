{
  config,
  pkgs,
  ...
}: {
  # copy whole directory to ~/.config/eww
  home.file."eww" = {
    source = ./config;
    recursive = true;
  };

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
