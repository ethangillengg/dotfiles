{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # TODO: Configure these in home-manager
    discord
    cava
    xfce.thunar
    pfetch
    font-manager
    obs-studio
    firefox
    osu-lazer-bin
    webcord-vencord
    steam
    mpv
    qbittorrent
    yt-dlp

    pavucontrol
    # pass-wayland
    youtube-music
    termusic
    ffmpeg

    unoconv # convert .doc, .docx files
  ];
}
