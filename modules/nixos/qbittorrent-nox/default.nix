{ config, pkgs, lib, ... }:
with lib;

let
  cfg = config.services.qbittorrent-nox;
  qbittorrentConfigDir = "/var/lib/qbittorrent";
in
{
  options.services.qbittorrent-nox = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable qbittorrent-nox service.";
    };
    user = mkOption {
      type = types.str;
      default = "qbittorrent";
      description = "The user which qbittorrent will run on";
    };
    group = mkOption {
      type = types.str;
      default = "qbittorrent";
      description = "The group of the user which qbittorrent will run on";
    };
    port = mkOption {
      type = types.int;
      default = 8080;
      description = "The port for the webui";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.qbittorrent-nox ];

    systemd.services.qbittorrent-nox = {
      description = "qBittorrent webui";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        # Type = "oneshot";
        RemainAfterExit = "yes";
        Restart = "always";
        RestartSec = "5";
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox --webui-port=${toString cfg.port} --profile=${qbittorrentConfigDir} -d";
      };
    };

    systemd.tmpfiles.rules = [
      "d ${qbittorrentConfigDir} 0755 ${cfg.user} ${cfg.group} -"
    ];


    users.groups.${cfg.group} = { };
    users.extraUsers.${cfg.user} = {
      isSystemUser = true;
      group = cfg.group;
    };
  };

}

