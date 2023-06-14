{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qemu
    virt-viewer # Optional, for GUI
    virt-manager
  ];
}
