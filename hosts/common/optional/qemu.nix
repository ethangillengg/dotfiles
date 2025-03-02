{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qemu
    virt-viewer # Optional, for GUI
    virt-manager
    virtiofsd
  ];
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.groups.libvirtd.members = ["ethan"];

  boot = {
    kernelParams = ["amd_iommu=on"];
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
    ];
    extraModprobeConfig = ''
      softdep nvidia pre: vfio-pci
      options vfio-pci ids=10de:1b80,10de:10f0
    '';
  };
}
