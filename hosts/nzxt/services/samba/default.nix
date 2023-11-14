{
  pkgs,
  config,
  ...
}: {
  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients

  services.samba = {
    enable = true;
    securityType = "user";

    # This adds to the [global] section:
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      kernel oplocks = yes
      read raw = Yes
      write raw = Yes
      socket options = TCP_NODELAY IPTOS_LOWDELAY SO_RCVBUF=131072 SO_SNDBUF=131072
    '';

    shares = {
      media = {
        path = "/mnt/mediaserver/data/media";
        browseable = "yes";
        "read only" = "no";
        "writeable" = "yes";
        "create mask" = "0644";
        "directory mask" = "0775";
        "force user" = "media";
        "force group" = "media";
      };
    };
  };

  # Curiously, `services.samba` does not automatically open
  # the needed ports in the firewall.
  networking.firewall.allowedTCPPorts = [445 139 5357];
  networking.firewall.allowedUDPPorts = [137 138 3702];
}
