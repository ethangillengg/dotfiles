{pkgs}: {
  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients

  services.samba = {
    enable = true;
    securityType = "user";

    # This adds to the [global] section:
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smbnix
      netbios name = smbnix
      security = user
      #use sendfile = yes
      guest account = media
      map to guest = bad user
    '';

    # securityType = "none";
    shares = {
      media = {
        path = "/mnt/mediaserver/media";
        browseable = "yes";
        "read only" = "no";
        "writeable" = "yes";
        "null passwords" = "yes";
        "guest ok" = "yes";
        "create mask" = "0775";
        "directory mask" = "0775";
        "force user" = "media";
        "force group" = "media";
      };

      # ethanpc = {
      #   path = "/mnt/mediaserver/ethan";
      #   browseable = "yes";
      #   "writeable" = "yes";
      #   "null passwords" = "yes";
      #   "guest ok" = "yes";
      #   "create mask" = "0644";
      #   "directory mask" = "0755";
      #   "force user" = "ethan";
      #   "force group" = "users";
      # };
    };
  };

  # Curiously, `services.samba` does not automatically open
  # the needed ports in the firewall.
  networking.firewall.allowedTCPPorts = [445 139 5357];
  networking.firewall.allowedUDPPorts = [137 138 3702];

  # To make SMB mounting easier on the command line
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };
}
