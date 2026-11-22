{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # TODO: Configure these in home-manager
    cava
    font-manager
    qbittorrent
    easyeffects
    vial

    pavucontrol
    google-chrome

    vesktop # discord client
    osu-lazer-bin

    yt-dlp
    tofi

    inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    rose-pine-cursor
    recyclarr
  ];
}
