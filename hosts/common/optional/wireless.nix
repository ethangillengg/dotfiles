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
      "SPSETUP-212C" = {
        psk = "@SPSETUP212C@";
      };
      "MIGNET" = {
        psk = "@MIGNET@";
      };
      "NOKIA-7A02" = {
        psk = "@NOKIA7A02@";
      };
      "eduroam" = {
        # key_mgmt=WPA-EAP
        # pairwise=CCMP
        # auth_alg=OPEN
        # eap=PEAP
        # phase2="auth=MSCHAPV2"
        auth = ''
          key_mgmt=WPA-EAP
          eap=PWD
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
