{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qemu
    virt-viewer # Optional, for GUI
    virt-manager
    virtiofsd
  ];
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
