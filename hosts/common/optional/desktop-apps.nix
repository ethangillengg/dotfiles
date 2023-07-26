{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # TODO: Configure these in home-manager
    cava
    xfce.thunar
    pfetch
    font-manager
    firefox
    osu-lazer-bin
    webcord-vencord
    steam
    obsidian
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
