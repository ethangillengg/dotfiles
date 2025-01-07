{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./network-fs.nix

    ../common
    ../common/optional/desktop
    ../common/optional/laptop.nix
    ../common/optional/distributed-builds.nix
    ../common/optional/x11-no-suspend.nix
    ../common/optional/greetd.nix
    ../common/optional/quietboot.nix
    ../common/optional/wireless.nix
    ../common/optional/touchpad-fix.nix
  ];
  networking.hostName = "thinkpad";
  services.blueman.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  home-manager.users.ethan = import ../../home/ethan/thinkpad.nix;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
