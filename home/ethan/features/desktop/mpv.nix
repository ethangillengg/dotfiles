{pkgs, ...}: {
  home.packages = with pkgs; [
    yt-dlp
    jellyfin-mpv-shim
  ];

  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.thumbnail
      mpvScripts.quality-menu
    ];
    config = {
      ## Languages
      alang = "jp,jpn,ja,Japanese,japanese,en,eng";
      slang = "jp,jpn,ja,Japanes,japanese,en,eng";
      sub-auto = "fuzzy";

      audio-display = "no";
      cache-pause = "no";
      cache = "yes";
      mute = "no";
      osc = "no";

      ## Screenshots
      screenshot-directory = "~/Pictures/mpv-screenshots/";
      screenshot-format = "png";

      ## Performance Fixes
      # See: https://wiki.archlinux.org/title/Mpv
      gpu-context = "wayland";
      vo = "gpu";
      # resample audio on desync (dropped frames)
      video-sync = "display-resample";
      # makes motion appear smoother
      interpolation = true;
      tscale = "oversample";
      # fix slow HDR playback
      hdr-compute-peak = "no";

      ## Youtube
      ytdl-format = "bestvideo[height<=?1440][vcodec!=?vp9]+bestaudio/best";
      save-position-on-quit = true;
    };
  };
}
