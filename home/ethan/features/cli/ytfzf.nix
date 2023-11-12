{pkgs, ...}: let
  rofi = "${pkgs.rofi}/bin/rofi";
  wezterm = "${pkgs.wezterm}/bin/wezterm";
in {
  # youtube cli
  home.packages = with pkgs; [
    ytfzf
  ];

  # Write config
  xdg.configFile."ytfzf/conf.sh".text = ''
    fzf_preview_side=right
    async_thumbnails=1
    show_thumbnails=1
  '';

  home.shellAliases = {
    # Play lofi-girl (audio-only)
    lofi = "ytfzf -m lofi";
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
# hello bro
