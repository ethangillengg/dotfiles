{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
    ./services

    ../common
    ../common/optional/desktop
    ../common/optional/greetd.nix
    ../common/optional/nixos-direnv.nix
    ../common/optional/docker.nix
    ../common/optional/tailscale-exit-node.nix
    ../common/optional/wine.nix
  ];

  networking.hostName = "nzxt";
  networking.networkmanager.enable = true;

  users.users.ethan = {
    openssh.authorizedKeys.keys = [
      #thinkpad
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE0haeLHMxd2Q40l9P5Aj63CDOZ5ntbBQXvHRyrMy9SJ8HC737LZC6zIAsXabEify5j4vBu1K6eafMvUbRmI34EtzRCeNKd8SoeH6up4o5lTB5bJGj5uRL2tk8kQyzXt/mpzdyM7i+nvpcEDmOIBTnfQ7NiYvM228i7P1ktT7INw8FwalpwxrMlGO0hH86rr7jKodOt//3xCioGxT3BmSufPnBljXjfLw4DmcRqL4rZBxnlk8VxpavwYCohMRzZ5w2Q5w2eybCfhtRWrXj4uEuv6YTFlh7r04ZUPTfzOrLUZyM9J1zUBmvuXRWY6+W4DVFAZ849mJOFFTFafSLx8ubmxwS+rfbX5nsF5MjAhm28N2JLnIjQtNqpIP9gkd5krBzVrYYj4SPrgxOjPc78IoB5T5SAEYP5gLw701JUgaTMrBfGEAtiVvfwv4dtmdRM7eIjoaVnD5DrBpl0DCl3I8biRC8B9fiKL32d06wOrUjBfHiA5peFSYQEoiKKewYgQ8= ethan"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID05CATYAdzNOm5xtlQIlFzStZzxLsQGq5t8Q+0oXdIT ethan"
    ];
  };

  users.users.media = {
    isNormalUser = lib.mkForce true;
  };

  nix.settings.trusted-users = ["root" "ethan"];

  home-manager.users.ethan = import ../../home/ethan/nzxt.nix;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
