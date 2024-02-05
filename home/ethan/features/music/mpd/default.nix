{config, ...}: {
  imports = [./misc.nix];

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    dataDir = "${config.home.homeDirectory}/.config/mpd";
    playlistDirectory = "${config.home.homeDirectory}/Music";
    extraConfig = ''
      auto_update           "yes"
      restore_paused        "yes"
      save_absolute_paths_in_playlists "no"
      audio_output {
        type "pipewire"
        name "PipeWire sound server"
        server "127.0.0.1" # add this line - MPD must connect to the local sound server
      }

      audio_output {
      	type                "fifo"
      	name                "Visualizer"
      	format              "44100:16:2"
      	path                "/tmp/mpd.fifo"
      }
    '';
    network.startWhenNeeded = true;
  };
}
