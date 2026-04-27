{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    oversteer
    mangohud
  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];
  };
}
