# This file (and the global directory) holds config that i use on all hosts
{ config, pkgs, stdenv, meta, inputs, outputs, ... }:
{
  imports = [
    ./openssh.nix
    ./hyprland.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };


  environment.systemPackages = with pkgs; [
    # Code
    gcc
    cargo
    gnumake
    git

    vim
    neovim
    python3Packages.virtualenv
    vscodium-fhs
    python39
    pfetch
    wl-clipboard
    pciutils
    unzip
    btop

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
    webcord
    ripgrep
    stylua
    mpv
    pavucontrol
    yt-music
    qbittorrent
  ];



  documentation.man.man-db.enable = false;
  environment = {
    variables = {
      MANPAGER = "sh -c 'col -bx | bat -p -lman --theme base16'";
      EDITOR = "nvim";
    };
  };
}
