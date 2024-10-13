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
    secretsFile = config.sops.secrets.wireless.path;
    networks = {
      "FBI Recruitment Van".pskRaw = "ext:FBI";
      "MIGNET".pskRaw = "ext:MIGNET";
      "NOKIA-7A02".pskRaw = "ext:NOKIA7A02";
      "Ethan-OnePlus".pskRaw = "ext:HOTSPOT";
      "bill wi the science fi_5G-2". pskRaw = "ext:bill_wi_science_fi";
      "eduroam".auth = ''
        key_mgmt=WPA-EAP
        pairwise=CCMP
        auth_alg=OPEN
        eap=PEAP
        phase2="auth=MSCHAPV2"
        identity="ethan.gill@ucalgary.ca"
        password="ext:EDUROAM"
      '';
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
