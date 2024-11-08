{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./services
    # ./gillserver-samba.nix #TODO: Fix this

    ../common
    ../common/optional/desktop-apps.nix
    # ../common/optional/greetd.nix
    ../common/optional/nixos-direnv.nix
    ../common/optional/docker.nix
    ../common/optional/tailscale-exit-node.nix
  ];

  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.

  networking.hostName = "nzxt";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Edmonton";
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ethan = {
    isNormalUser = true;
    description = "ethan";
    extraGroups = ["networkmanager" "wheel" "mediaserver" "docker"];
    openssh.authorizedKeys.keys = [
      #thinkpad
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE0haeLHMxd2Q40l9P5Aj63CDOZ5ntbBQXvHRyrMy9SJ8HC737LZC6zIAsXabEify5j4vBu1K6eafMvUbRmI34EtzRCeNKd8SoeH6up4o5lTB5bJGj5uRL2tk8kQyzXt/mpzdyM7i+nvpcEDmOIBTnfQ7NiYvM228i7P1ktT7INw8FwalpwxrMlGO0hH86rr7jKodOt//3xCioGxT3BmSufPnBljXjfLw4DmcRqL4rZBxnlk8VxpavwYCohMRzZ5w2Q5w2eybCfhtRWrXj4uEuv6YTFlh7r04ZUPTfzOrLUZyM9J1zUBmvuXRWY6+W4DVFAZ849mJOFFTFafSLx8ubmxwS+rfbX5nsF5MjAhm28N2JLnIjQtNqpIP9gkd5krBzVrYYj4SPrgxOjPc78IoB5T5SAEYP5gLw701JUgaTMrBfGEAtiVvfwv4dtmdRM7eIjoaVnD5DrBpl0DCl3I8biRC8B9fiKL32d06wOrUjBfHiA5peFSYQEoiKKewYgQ8= ethan"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID05CATYAdzNOm5xtlQIlFzStZzxLsQGq5t8Q+0oXdIT ethan"
    ];
  };

  home-manager.users.ethan = import ../../home/ethan/nzxt.nix;

  users.users.media = {
    isNormalUser = lib.mkForce true;
  };

  nix.settings.trusted-users = ["root" "ethan"];
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
