# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, stdenv, meta, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./../common
      ./../common/optional/distributedBuilds.nix
    ];

  #enable fingerprint sensors
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = inputs.nixos-06cb-009a-fingerprint-sensor.lib.libfprint-2-tod1-vfs0090-bingch {
        calib-data-file = ./calib-data.bin; #fingerprint data from python-validity
      };
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;
  hardware.trackpoint.enable = true;
  # services.fprintd.enable = true; #fingerprint scanner
  programs.fish.enable = true;


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.hostName = "thinkpad"; # Define your hostname.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;
  networking.enableIPv6 = false;
  # networking.networkmanager.enable = true;
  # powerManagement.enable = false;
  networking.networkmanager.wifi.backend = "iwd";

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ethan = {
    isNormalUser = true;
    description = "ethan";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
    # shell = "fish";
  };

  security.sudo.wheelNeedsPassword = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wl-clipboard
    neovim
    pciutils
    wirelesstools

    #  wget
    # osu-lazer-bin
    # osu-overlay.osu-lazer-bin
  ];


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
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  # nixpkgs.overlays = [ osu-overlay ];

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
