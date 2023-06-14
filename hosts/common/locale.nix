{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    glibcLocales
  ];
  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };
  time.timeZone = lib.mkDefault "America/Edmonton";
}
