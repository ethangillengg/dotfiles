{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix

    ./../common
    ./../common/optional/desktop-apps.nix
    # ./../common/optional/distributed-builds.nix
    ./../common/optional/x11-no-suspend.nix
    ./../common/optional/greetd.nix
    # ./../common/optional/power-management.nix
    ./../common/optional/quietboot.nix
    ./../common/optional/jellyfin-mpv-shim.nix
    # ./../common/optional/wine.nix
    ./../common/optional/vpn.nix
    # ./../common/optional/qemu.nix
  ];
  networking.hostName = "thinkpad";
  networking.networkmanager.enable = true;

  programs = {
    light.enable = true;
    adb.enable = true;
  };
  services.blueman.enable = true;

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;
  hardware.trackpoint.enable = true;
  programs.fish.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.ethan = {
    isNormalUser = true;
    description = "ethan";
    extraGroups = ["wheel" "networkmanager" "docker"];
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  fonts.fontconfig = {
    localConf = ''
    '';
  };
}
