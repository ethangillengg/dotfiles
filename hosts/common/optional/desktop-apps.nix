{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
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
    obsidian
    # webcord

    unoconv # convert .doc, .docx files
    renderdoc

    yt-dlp
    eww-wayland
    tofi
    st

    gnome.gnome-calculator

    inputs.ripgrep-all.packages.x86_64-linux.default
  ];
}
