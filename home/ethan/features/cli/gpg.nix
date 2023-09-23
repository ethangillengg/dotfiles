{pkgs, ...}: let
  pinentry = {
    packages = [pkgs.pinentry-curses];
    name = "curses";
  };
in {
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [""];
    pinentryFlavor = pinentry.name;
    enableExtraSocket = true;
  };
}
