# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  modulesPath,
  ...
}: let
  mediaserverMountOpts = {
    device = "/dev/disk/by-uuid/45efa216-f3b6-4925-89c8-2a30845e95cf";
    fsType = "btrfs";
  };
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl.enable = true;
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
  };

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/e8638e15-0774-4f3a-ba54-f093f4f74376";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/E8BD-954B";
      fsType = "vfat";
    };

    "/mediaserver/media" =
      {
        options = ["subvol=media"];
      }
      // mediaserverMountOpts;

    "/mediaserver/other" =
      {
        options = ["subvol=other"];
      }
      // mediaserverMountOpts;

    "/mediaserver/torrents" =
      {
        options = ["subvol=torrents"];
      }
      // mediaserverMountOpts;

    "/mediaserver/usenet" =
      {
        options = ["subvol=usenet"];
      }
      // mediaserverMountOpts;

    "/export/media" = {
      device = "/mediaserver/media";
      options = ["bind"];
    };
  };

  swapDevices = [];
  networking.useDHCP = false; # static ip
  networking.enableIPv6 = false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
