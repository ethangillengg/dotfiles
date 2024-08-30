{
  lib,
  config,
  ...
}: {
  # Wireless secrets stored through sops
  sops.secrets.wireless = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };
  networking.networkmanager.enable = lib.mkForce false;

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = false;
    # Declarative
    environmentFile = config.sops.secrets.wireless.path;
    networks = {
      "FBI Recruitment Van" = {
        psk = "@FBI@";
      };
      "MIGNET" = {
        psk = "@MIGNET@";
      };
      "NOKIA-7A02" = {
        psk = "@NOKIA7A02@";
      };

      "Ethan-OnePlus" = {
        psk = "@HOTSPOT@";
      };

      "bill wi the science fi_5G-2" = {
        psk = "@bill_wi_science_fi@";
      };
      "eduroam" = {
        auth = ''
          key_mgmt=WPA-EAP
          pairwise=CCMP
          auth_alg=OPEN
          eap=PEAP
          phase2="auth=MSCHAPV2"
          identity="ethan.gill@ucalgary.ca"
          password="@EDUROAM@"
        '';
      };
    };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };
    extraConfig = ''
      update_config=1
    '';
  };

  # Ensure group exists
  users.groups.network = {};

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
