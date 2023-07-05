{pkgs, ...}: {
  services.power-profiles-daemon.enable = true;
  powerManagement.powertop.enable = true;
  environment.systemPackages = with pkgs; [
    powertop
  ];
}
