{
  pkgs,
  config,
  ...
}: let
  nfsMountOptions = [
    "x-systemd.automount"
    "noauto"
    "noatime"
    "x-systemd.idle-timeout=600" # disconnects after 10 minutes idle (i.e. 600 seconds)
  ];

  sambaMountOptions = [
    "x-systemd.automount"
    "noauto"
    "x-systemd.idle-timeout=600"
    "x-systemd.device-timeout=2s"
    "x-systemd.mount-timeout=5s"
    "vers=3.0" # Use the highest protocol version supported by both client and server for better performance
    "credentials=${config.sops.secrets.samba-credentials.path}"
    "uid=1000" # Replace 1000 with the actual user ID
    "gid=100" # Replace 100 with the actual group ID
    "file_mode=0775" # Modify as needed based on your permissions requirements
    "dir_mode=0775" # Modify as needed based on your permissions requirements
    "cache=strict" # Use 'strict' or 'none' depending on needs (default is 'loose')
    "rsize=1048576" # Read buffer size (1MB); increase if you have large reads
    "wsize=1048576" # Write buffer size (1MB); increase if you have large writes
    "actimeo=1" # The attribute cache timeout in seconds (shorter might lead to more requests but ensures freshness)
    "nobrl" # Disable byte-range locking if not necessary
  ];
  mediaServer = "100.113.35.34";
in {
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = with pkgs; [cifs-utils nfs-utils];

  # SAMBA
  fileSystems = {
    "/mnt/samba/data" = {
      device = "//${mediaServer}/data";
      fsType = "cifs";
      options = sambaMountOptions;
    };
    "/mnt/samba/media" = {
      device = "//${mediaServer}/media";
      fsType = "cifs";
      options = sambaMountOptions;
    };
  };

  # NFS
  fileSystems = {
    "/mnt/nfs/data" = {
      device = "${mediaServer}:/data";
      fsType = "nfs";
      options = nfsMountOptions;
    };
    "/mnt/nfs/media" = {
      device = "${mediaServer}:/media";
      fsType = "nfs";
      options = nfsMountOptions;
    };
  };

  sops.secrets.samba-credentials = {
    sopsFile = ../common/secrets.yaml;
  };
}
