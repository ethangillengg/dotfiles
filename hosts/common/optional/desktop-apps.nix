{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # TODO: Configure these in home-manager
    cava
    pfetch
    font-manager
    ungoogled-chromium
    google-chrome
    qbittorrent

    pavucontrol
    termusic
    ffmpeg
    wayvnc
    steam
    foot

    vesktop # discord client
    osu-lazer-bin

    unoconv # convert .doc, .docx files
    renderdoc

    yt-dlp
    tofi

    gnome.gnome-calculator
  ];
}
