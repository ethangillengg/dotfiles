{pkgs, ...}: let
  pinentryPackage = pkgs.pinentry-tty;

  minsToSecs = mins: (mins * 60);
in {
  home.packages = [pinentryPackage];

  home.file.".gnupg/gpg.conf".source = ./gpg.conf;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = minsToSecs 30;
    enableExtraSocket = true;
    inherit pinentryPackage;
  };
}
