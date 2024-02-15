{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = ["thinkpad_acpi" "xhci_pci" "nvme" "usb_storage" "sd_mod"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    # Avoid touchpad click to tap (clickpad) bug. For more detail see:
    # https://wiki.archlinux.org/title/Touchpad_Synaptics#Touchpad_does_not_work_after_resuming_from_hibernate/suspend
    kernelParams = ["psmouse.synaptics_intertouch=1" "intel_pstate=disable"];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };
  hardware = {
    bluetooth.enable = true;
    trackpoint = {
      enable = true;
      sensitivity = 200;
    };
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];
      driSupport32Bit = true;
    };
    enableAllFirmware = true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/3e483fd2-4714-4b1c-8137-83f96a683b93";
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/c74fe5f9-bd7b-4f45-8b02-c0092747c18e";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd" "noatime"];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/c74fe5f9-bd7b-4f45-8b02-c0092747c18e";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };
    "/var/log" = {
      device = "/dev/disk/by-uuid/c74fe5f9-bd7b-4f45-8b02-c0092747c18e";
      fsType = "btrfs";
      options = ["subvol=log" "compress=zstd" "noatime"];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/c74fe5f9-bd7b-4f45-8b02-c0092747c18e";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd" "noatime"];
    };
    "/persist" = {
      device = "/dev/disk/by-uuid/c74fe5f9-bd7b-4f45-8b02-c0092747c18e";
      fsType = "btrfs";
      options = ["subvol=persist" "compress=zstd" "noatime"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BD03-913A";
      fsType = "vfat";
    };
  };
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  # networking.useDHCP = lib.mkDefault true;
  networking = {
    useDHCP = true; # Disable DHCP if you want manual control
  };

  services.throttled.enable = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  powerManagement.cpuFreqGovernor = "performance";

  boot.extraModprobeConfig = lib.mkMerge [
    # idle audio card after one second
    "options snd_hda_intel power_save=1"
    # enable wifi power saving (keep uapsd off to maintain low latencies)
    "options iwlwifi power_save=1 uapsd_disable=1"
  ];

  services.power-profiles-daemon.enable = lib.mkForce false;
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

      CPU_SCALING_MIN_FREQ_ON_AC = 800000;
      CPU_SCALING_MAX_FREQ_ON_AC = 3300000;
      CPU_SCALING_MIN_FREQ_ON_BAT = 800000;
      CPU_SCALING_MAX_FREQ_ON_BAT = 2300000;

      # Enable audio power saving for Intel HDA, AC97 devices (timeout in secs).
      # A value of 0 disables, >=1 enables power saving (recommended: 1).
      # Default: 0 (AC), 1 (BAT)
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;

      # Runtime Power Management for PCI(e) bus devices: on=disable, auto=enable.
      # Default: on (AC), auto (BAT)
      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      # Battery feature drivers: 0=disable, 1=enable
      # Default: 1 (all)
      NATACPI_ENABLE = 1;
      TPACPI_ENABLE = 1;
      TPSMAPI_ENABLE = 1;
    };
  };
}
