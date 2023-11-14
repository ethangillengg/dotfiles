{pkgs, ...}: let
  pinentry = {
    packages = [pkgs.pinentry-gnome pkgs.gcr];
    name = "gnome3";
  };

  minsToSecs = mins: (mins * 60);
in {
  home.packages = pinentry.packages;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = minsToSecs 30;
    sshKeys = [""];
    pinentryFlavor = pinentry.name;
    enableExtraSocket = true;
  };
}
