{pkgs, ...}: let
  wezterm = "${pkgs.wezterm}/bin/wezterm";
in {
  # youtube cli
  home.packages = with pkgs; [
    ytfzf
    ytmdl # download music
  ];

  # Write config
  xdg.configFile."ytfzf/conf.sh".text = ''
    async_thumbnails=0
    show_thumbnails=0
    yt_video_link_domain=https://www.youtube.com
    invidious_instance=inv.n8pjl.ca
  '';

  xdg.configFile."ytmdl/config".text = ''
    SONG_DIR = "/home/ethan/Music/.unimported"
  '';

  home.shellAliases = {
    # Play lofi-girl (audio-only)
    lofi = "ytfzf -m lofi";
    # search for music
    ytm = "ytfzf -m";
    # Fix for mpv osd and plugins
    yt = "mpv $(ytfzf -L)";
  };

  xdg = {
    desktopEntries = {
      lofi = {
        name = "Lofi";
        genericName = "Play Lofi";
        comment = "Search for lofi on YouTube and play it in mpv";
        exec = "${wezterm} start --class=\"lofi\" --always-new-process ytfzf --detach --audio-pref=bestaudio lofi";
        categories = ["Network"];
        type = "Application";
      };
    };
  };
}
