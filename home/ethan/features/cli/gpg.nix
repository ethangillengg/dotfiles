{pkgs, ...}: let
  pinentryPackage = pkgs.pinentry-qt;

  minsToSecs = mins: (mins * 60);
in {
  home.packages = [pinentryPackage];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = minsToSecs 30;
    enableExtraSocket = true;
    inherit pinentryPackage;
  };
}
