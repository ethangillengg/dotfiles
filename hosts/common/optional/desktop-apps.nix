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
    obsidian

    pavucontrol
    termusic
    ffmpeg
    wayvnc

    remmina
    obs-studio
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

    # inputs.object-viewer.defaultPackage.x86_64-linux
    inputs.ripgrep-all.packages.x86_64-linux.default
  ];
}
