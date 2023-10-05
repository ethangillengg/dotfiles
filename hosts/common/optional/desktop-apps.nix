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
    yt-dlp

    pavucontrol
    termusic
    ffmpeg

    webcord-vencord
    obs-studio

    unoconv # convert .doc, .docx files
    renderdoc

    llama
  ];
}
