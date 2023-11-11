{pkgs, ...}: {
  home.packages = with pkgs; [
    yt-dlp
    jellyfin-mpv-shim
  ];

  programs.mpv = {
    enable = true;
    scripts = with pkgs; [
      mpvScripts.thumbfast
      mpvScripts.quality-menu
      mpvScripts.uosc
    ];

    scriptOpts = {
      thumbfast = {
        # show thumnails for youtube
        network = "yes";
      };
    };

    config = {
      ## Languages
      alang = "jp,jpn,ja,Japanese,japanese,en,eng";
      slang = "jp,jpn,ja,Japanes,japanese,en,eng";
      sub-auto = "fuzzy";

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
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
      save-position-on-quit = true;

      ## Misc.
      audio-display = "no";
      cache-pause = "no";
      cache = "yes";
      mute = "no";
      osd-bar = "no";
    };
    bindings = {
      ## Show UOSC
      "space" = "cycle pause; script-binding uosc/flash-pause-indicator";
      "l" = "seek  5; script-binding uosc/flash-timeline";
      "h" = "seek -5; script-binding uosc/flash-timeline";
      "right" = "seek  5; script-binding uosc/flash-timeline";
      "left" = "seek -5; script-binding uosc/flash-timeline";

      ## Subtitles controls
      "w" = "sub-seek 1";
      "shift+w" = "sub-seek -1";
      "b" = "sub-seek -1";
      "ctrl+w" = "sub-step 1";
      "ctrl+shift+w" = "sub-step -1";
      "ctrl+b" = "sub-step -1";

      ## Seeking
      "shift+l" = "seek  30; script-binding uosc/flash-timeline";
      "shift+h" = "seek -30; script-binding uosc/flash-timeline";
      "shift+right" = "seek  30; script-binding uosc/flash-timeline";
      "shift+left" = "seek -30; script-binding uosc/flash-timeline";

      ## Volume controls
      "m" = "no-osd cycle mute; script-binding uosc/flash-volume";
      "up" = "no-osd add volume  10; script-binding uosc/flash-volume";
      "down" = "no-osd add volume -10; script-binding uosc/flash-volume";
      "k" = "no-osd add volume  10; script-binding uosc/flash-volume";
      "j" = "no-osd add volume -10; script-binding uosc/flash-volume";

      ## Show menus
      "ctrl+p" = "script-binding uosc/items";
      "ctrl+v" = "script-binding uosc/subtitles";
      "ctrl+shift+v" = "script-binding uosc/load-subtitles";
      "ctrl+f" = "script-binding quality_menu/video_formats_toggle";
      "ctrl+alt+f" = "script-binding quality_menu/audio_formats_toggle";

      ## Misc.
      # Flash title and timeline
      "tab" = "script-message-to uosc toggle-elements timeline,top_bar";
      "ctrl+s" = "screenshot";
      "[" = "no-osd add speed -0.25; script-binding uosc/flash-speed";
      "]" = "no-osd add speed  0.25; script-binding uosc/flash-speed";
      "\\" = "no-osd set speed 1; script-binding uosc/flash-speed";
      ">" = "script-binding uosc/next; script-message-to uosc flash-elements top_bar,timeline";
      "<" = "script-binding uosc/prev; script-message-to uosc flash-elements top_bar,timeline";

      # Set everything back to default
      "f5" = "set contrast 0;set brightness 0;set gamma 0;set saturation 0;set hue 0;set sub-pos 100;set sub-scale 1;set panscan 0;set zoom 0;show-text default";
    };
  };
}
