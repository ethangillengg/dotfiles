# This file (and the global directory) holds config that i use on all hosts
{
  pkgs,
  lib,
  outputs,
  ...
}: {
  imports =
    [./openssh.nix ./hyprland.nix ./locale.nix]
    ++ (builtins.attrValues outputs.nixosModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  environment.systemPackages = with pkgs; [
    # Code
    gcc
    cargo
    gnumake
    git
    wget

    nil
    alejandra
    stylua
    lua-language-server
    rust-analyzer
    rustfmt

    libsForQt5.polkit-kde-agent
    discord
    samba

    cava
    rustup
    nodejs
    sshfs
    vim
    neovim
    xfce.thunar
    python3Packages.virtualenv
    vscodium-fhs
    python39
    pfetch
    wl-clipboard
    pciutils
    unzip
    btop
    font-manager

    # Linux util replacements
    duf
    dua
    xh
    jqp
    jq
    fzf

    # TODO: Configure these in home-manager
    obs-studio
    firefox
    osu-lazer-bin
    webcord-vencord
    steam
    ripgrep
    mpv
    pavucontrol
    yt-music
    qbittorrent
    mpv
    pass-wayland
    youtube-music
  ];

  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };

  documentation.man.man-db.enable = false;
  environment = {
    variables = {
      MANPAGER = "sh -c 'col -bx | bat -p -lman --theme base16'";
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
    };
  };
}
