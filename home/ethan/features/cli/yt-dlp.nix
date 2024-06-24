{
  programs.yt-dlp = {
    enable = true;
    extraConfig = ''
      -o "~/Downloads/%(playlist_index&{} - |)s%(title)s [%(id)s].%(ext)s"
    '';
  };
}
