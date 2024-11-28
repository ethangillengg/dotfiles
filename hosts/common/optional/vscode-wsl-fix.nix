{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.wget
  ];
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs; # only for NixOS 24.05
  };
}
