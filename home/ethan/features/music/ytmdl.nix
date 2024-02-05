{pkgs, ...}: {
  # download music
  home.packages = with pkgs; [
    ytmdl
  ];

  # Write config
  xdg.configFile."ytmdl/config".text = ''
    SONG_DIR = "/home/ethan/Music/.unimported"
  '';
}
