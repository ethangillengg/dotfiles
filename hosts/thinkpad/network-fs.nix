{pkgs, ...}: let
  mediaServer = "100.113.35.34";
in {
  # For mount.cifs, required unless domain name resolution is not needed.
  environment.systemPackages = with pkgs; [cifs-utils nfs-utils];
  services.rpcbind.enable = true; # needed for NFS

  systemd.mounts = let
    commonMountOptions = {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
    };
  in [
    (commonMountOptions
      // {
        what = "${mediaServer}:/export/media";
        where = "/mnt/nfs/media";
      })
  ];

  systemd.automounts = let
    commonAutoMountOptions = {
      wantedBy = ["multi-user.target"];
      after = ["tailscale-online.target"];

      automountConfig = {
        TimeoutIdleSec = "600";
      };
    };
  in [
    (commonAutoMountOptions // {where = "/mnt/nfs/media";})
  ];

  # "tailscale-online.target" to only mount nfs shares when tailnet is up
  # see: https://forum.tailscale.com/t/mount-share-only-if-connected-to-tailscale/3027/7
  systemd.timers."tailscale-dispatcher" = {
    bindsTo = ["tailscaled.service"];
    after = ["tailscaled.service"];
    wantedBy = ["tailscaled.service"];
    timerConfig = {
      OnBootSec = "0";
      OnUnitInactiveSec = "10";
      AccuracySec = "1";
    };
  };
  systemd.services."tailscale-dispatcher" = {
    requisite = ["tailscaled.service"];
    after = ["tailscaled.service"];
    serviceConfig.Type = "oneshot";
    script = with pkgs; ''
      get-state() {
        if ${systemd}/bin/systemctl is-active --quiet tailscaled.service && [[ $(${tailscale}/bin/tailscale status --peers=false --json=true | ${jq}/bin/jq -r '.Self.Online') = "true" ]]; then
          current_state="online"
        else
          current_state="offline"
        fi
      }
      transition() {
        if [[ "$current_state" != "$prev_state" ]]; then
          if [[ "$current_state" = "online" ]]; then
            ${systemd}/bin/systemctl start tailscale-online.target
          else
            ${systemd}/bin/systemctl stop tailscale-online.target
          fi
          echo "$current_state" > /tmp/tailscale-state
        fi
      }
      check-state() {
        get-state
        if [[ -s /tmp/tailscale-state ]]; then
          prev_state=$(</tmp/tailscale-state)
        else
          prev_state="offline"
        fi
        transition
      }
      check-state
    '';
  };
  systemd.targets."tailscale-online" = {
    after = ["tailscaled.service"];
    bindsTo = ["tailscaled.service"];
  };
}
