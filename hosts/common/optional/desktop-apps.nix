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

    vesktop
    osu-lazer-bin
    # webcord

    unoconv # convert .doc, .docx files
    renderdoc

    yt-dlp
    tofi

    gnome.gnome-calculator
  ];
}
