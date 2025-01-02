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

    pavucontrol
    steam

    vesktop # discord client
    osu-lazer-bin

    yt-dlp
    tofi

    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    rose-pine-cursor
  ];
}
