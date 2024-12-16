# This file (and the global directory) holds config that i use on all hosts
{
  pkgs,
  lib,
  outputs,
  inputs,
  ...
}: let
  bat = "${pkgs.bat}/bin/bat";
in {
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
      ./openssh.nix
      ./locale.nix
      ./nix.nix
      ./nvim.nix
      ./sops.nix
      ./tailscale.nix
      ./thunar.nix
      ./ethan.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager.extraSpecialArgs = {inherit inputs outputs;};
  programs.dconf.enable = true; # see nixpkgs #3113 (https://github.com/nix-community/home-manager/issues/3113)

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
    unzip
    zip
    rar
    pciutils
    btop
    ripgrep
    fd

    samba
  ];

  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome.gvfs;
  };

  # needed for store VS Code auth token
  services.gnome.gnome-keyring.enable = true;

  security.pam.services.swaylock = {};

  security.sudo.wheelNeedsPassword = false;
  documentation.man.man-db.enable = false;
  environment = {
    variables = {
      MANPAGER = "sh -c 'col -bx | ${bat} -p -lman'";
      MANROFFOPT = "-c";
      EDITOR = "nvim";
      NIXOS_OZONE_WL = "1";
    };
  };
}
