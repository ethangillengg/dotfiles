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
    qbittorrent

    pavucontrol
    feishin
    ffmpeg
    wayvnc
    steam

    vesktop # discord client
    osu-lazer-bin

    unoconv # convert .doc, .docx files

    yt-dlp
    tofi

    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    rose-pine-cursor
  ];
}
