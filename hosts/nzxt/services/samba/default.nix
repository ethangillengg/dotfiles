{...}: {
  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients

  services.samba = {
    enable = true;
    securityType = "user";

    # This adds to the [global] section:
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix

      # Disables opportunistic locking if not required
      kernel oplocks = no
      locking = no

      # Optimizes I/O operations
      read raw = Yes
      write raw = Yes
      aio read size = 16384
      aio write size = 16384

      # Improves socket performance
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

      data = {
        path = "/mnt/mediaserver/data";
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

  services.nfs.server = {
    enable = true;
    exports = ''
      /export         100.66.165.20(rw,fsid=0,no_subtree_check,all_squash,anonuid=1003,anongid=988)
      /export/data    100.66.165.20(rw,nohide,insecure,no_subtree_check,all_squash,anonuid=1003,anongid=988)
      /export/media   100.66.165.20(rw,nohide,insecure,no_subtree_check,all_squash,anonuid=1003,anongid=988)
    '';

    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
  };

  # Curiously, `services.samba` does not automatically open
  # the needed ports in the firewall.
  networking.firewall.allowedTCPPorts = [445 139 5357 111 2049 4000 4001 4002 20048];
  networking.firewall.allowedUDPPorts = [137 138 3702 111 2049 4000 4001 4002 20048];
}
