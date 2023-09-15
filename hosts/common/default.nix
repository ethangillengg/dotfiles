# This file (and the global directory) holds config that i use on all hosts
{
  pkgs,
  lib,
  outputs,
  inputs,
  ...
}: {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./openssh.nix
      ./hyprland.nix
      ./locale.nix
      ./nix.nix
      ./nvim.nix
      ./sops.nix
    ]
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

    #my utils
    vim
    duf
    dua
    xh
    jqp
    jq
    fzf
    unp #unpack .zip, .tar, .rar with one command
    unzip
    zip
    rar
    pciutils
    btop
    ripgrep

    samba
  ];

  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };

  security.pam.services = {swaylock = {};};

  documentation.man.man-db.enable = false;
  environment = {
    variables = {
      MANPAGER = "sh -c 'col -bx | bat -p -lman --theme base16'";
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
    };
  };
}
