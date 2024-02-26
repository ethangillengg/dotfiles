{
  pkgs,
  config,
  ...
}: let
  mediaUID = config.users.users.media.uid;
  mediaGID = config.users.groups.media.gid;
  options = ["ro" "uid=${toString mediaUID}" "gid=${toString mediaGID}"];
in {
  # TV SHOWS
  fileSystems."/mnt/gillserver/ImportedTV" = {
    device = "//192.168.1.198/ImportedTV";
    fsType = "cifs";
    inherit options;
  };

  fileSystems."/mnt/gillserver/ImportedTV2" = {
    device = "//192.168.1.198/ImportedTV2";
    fsType = "cifs";
    inherit options;
  };

  fileSystems."/mnt/gillserver/ImportedTV4" = {
    device = "//192.168.1.198/ImportedTV4";
    fsType = "cifs";
    inherit options;
  };

  fileSystems."/mnt/gillserver/ImportedTV5" = {
    device = "//192.168.1.198/ImportedTV5";
    fsType = "cifs";
    inherit options;
  };

  # MOVIES (don't ask why they are called "ImportedShows"...)
  fileSystems."/mnt/gillserver/ImportedShows" = {
    device = "//192.168.1.198/ImportedShows";
    fsType = "cifs";
    inherit options;
  };

  fileSystems."/mnt/gillserver/ImportedShows2" = {
    device = "//192.168.1.198/ImportedShows2";
    fsType = "cifs";
    inherit options;
  };

  fileSystems."/mnt/gillserver/ImportedShows4" = {
    device = "//192.168.1.198/ImportedShows4";
    fsType = "cifs";
    inherit options;
  };

  fileSystems."/mnt/gillserver/ImportedShows5" = {
    device = "//192.168.1.198/ImportedShows5";
    fsType = "cifs";
    inherit options;
  };

  environment.systemPackages = with pkgs; [cifs-utils];
}
