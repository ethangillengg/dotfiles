{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # TODO: Configure these in home-manager
    cava
    xfce.thunar
    pfetch
    font-manager
    firefox
    osu-lazer-bin
    steam
    qbittorrent

    pavucontrol
    termusic
    ffmpeg

    obs-studio
    armcord
    # webcord

    unoconv # convert .doc, .docx files
    renderdoc

    yt-dlp
    yt-music # chromium wrapper for yt music
  ];
}
