{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # TODO: Configure these in home-manager
    discord
    cava
    xfce.thunar
    pfetch
    font-manager
    obs-studio
    firefox
    osu-lazer-bin
    webcord-vencord
    steam
    mpv
    qbittorrent

    pavucontrol
    # pass-wayland
    youtube-music
  ];
}
