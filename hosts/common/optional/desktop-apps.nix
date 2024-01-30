{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # TODO: Configure these in home-manager
    cava
    pfetch
    font-manager
    ungoogled-chromium
    google-chrome
    steam
    qbittorrent

    pavucontrol
    termusic
    ffmpeg
    wayvnc

    remmina
    armcord
    osu-lazer-bin
    # webcord

    unoconv # convert .doc, .docx files
    renderdoc

    yt-dlp
    eww-wayland
    tofi
    st

    gnome.gnome-calculator
  ];
}
