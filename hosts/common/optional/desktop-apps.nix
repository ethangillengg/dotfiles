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
    feishin
    ffmpeg
    wayvnc
    steam

    vesktop # discord client
    osu-lazer

    unoconv # convert .doc, .docx files

    yt-dlp
    tofi
  ];
}
