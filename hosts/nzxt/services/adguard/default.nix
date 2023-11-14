{
  services.adguardhome = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.allowedUDPPorts = [53]; # Open DNS port
}
