# provides wgnord and makes configuration files
{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  wgnord-latest = pkgs.callPackage ../../../pkgs/wgnord-latest {};

  openresolv = pkgs.openresolv;
  coreutils = pkgs.coreutils;
  curl = pkgs.curl;
  gnugrep = pkgs.gnugrep;
  gnused = pkgs.gnused;
  iproute2 = pkgs.iproute2;
  jq = pkgs.jq;
  wireguard-tools = pkgs.wireguard-tools;

  cfg = config.services.wgnord;
in {
  options = {
    services.wgnord = {
      enable = mkEnableOption "Enable wgnord";
      tokenFile = mkOption {
        type = types.path;
        default = null;
        description = "Path to a file containing your NordVPN authentication token";
      };
      country = mkOption {
        type = types.str;
        default = "United States";
        description = "The country which wgnord will try to connect to";
      };
      template = mkOption {
        type = types.str;
        default = builtins.readFile (wgnord-latest + "/share/template.conf");
        description = "The template for the WireGuard interface wgnord will create";
      };
    };
  };

  config = mkIf cfg.enable {
    # Configure the systemd service
    systemd.services.wgnord = {
      description = "wgnord vpn service";
      after = ["network-online.target"];
      wants = ["network-online.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = "yes";
        ExecStartPre = "-${wgnord-latest}/bin/wgnord login \"\$(<${cfg.tokenFile})\"";
        ExecStart = "${wgnord-latest}/bin/wgnord connect \"${cfg.country}\"";
        ExecStop = "-${wgnord-latest}/bin/wgnord disconnect";
        User = "root";
        Group = "root";
        # Set the path variables, so we can use openresolv
        Environment = "PATH=${openresolv}/bin:${coreutils}/bin:${curl}/bin:${gnugrep}/bin:${gnused}/bin:${iproute2}/bin:${jq}/bin:${wireguard-tools}/bin:$PATH";
        Restart = "on-failure";
        RestartSec = "1s";
      };
    };

    networking.nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];

    services.resolved = {
      enable = true;
      dnssec = "true";
      domains = ["~."];
      fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
      dnsovertls = "true";
    };
    # Provide the template.conf file
    environment.etc."var/lib/wgnord/template.conf".text = cfg.template;

    systemd.tmpfiles.rules = [
      "d /etc/wireguard/ 755 root root"
      "f /etc/wireguard/wgnord.conf 600 root root"
    ];
  };
}
