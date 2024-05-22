{pkgs, ...}: {
  # see https://github.com/sakai135/wsl-vpnkit/blob/5084c6d/wsl-vpnkit.service
  systemd.services.wsl-vpnkit = {
    enable = true;
    description = "wsl-vpnkit";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      ExecStart = "${pkgs.wsl-vpnkit}/bin/wsl-vpnkit";
      Restart = "always";
      KillMode = "mixed";
    };
  };
}
