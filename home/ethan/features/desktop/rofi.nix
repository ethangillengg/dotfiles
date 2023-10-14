{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    extraConfig = {
      # columns=3
      # allow_images = true;
      # image_size = 48;
      # insensitive=true
      #
      # run-always_parse_args=true
      # run-cache_file=/dev/null
      # run-exec_search=true
    };
    pass = {
      enable = true;
    };
  };

  xdg.configFile."rofi/config".text = ''
  '';
}
