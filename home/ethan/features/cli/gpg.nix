{pkgs, ...}: let
  pinentry = {
    packages = [pkgs.pinentry-gnome pkgs.gcr];
    name = "gnome3";
  };
in {
  home.packages = pinentry.packages;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [""];
    pinentryFlavor = pinentry.name;
    enableExtraSocket = true;
  };
}
