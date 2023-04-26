# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, stdenv, meta, inputs, outputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./../common
    ./../common/optional/distributed-builds.nix
    # ./../common/optional/greetd.nix
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget

  #enable fingerprint sensors
  services.fprintd = {
    enable = false;
    tod = {
      enable = false;
      driver = inputs.nixos-06cb-009a-fingerprint-sensor.lib.libfprint-2-tod1-vfs0090-bingch {
        calib-data-file = ./calib-data.bin; #fingerprint data from python-validity
      };
    };
  };

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
    dconf.enable = true;
    kdeconnect.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;
  hardware.trackpoint.enable = true;
  # services.fprintd.enable = true; #fingerprint scanner
  programs.fish.enable = true;


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Enable networking
  networking.hostName = "thinkpad"; # Define your hostname.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  # networking.enableIPv6 = false;
  # networking.networkmanager.enable = true;
  # powerManagement.enable = false;
  # networking.networkmanager.wifi.backend = "iwd";

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the GNOME Desktop Environment.
  programs.sway.enable = true;

  # Configure keymap in X11
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
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
    # shell = "fish";
  };

  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
