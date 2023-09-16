{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    glibcLocales
  ];
  i18n = {
    defaultLocale = lib.mkForce "en_US.UTF-8";
    supportedLocales = lib.mkForce [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };
  time.timeZone = lib.mkDefault "America/Edmonton";
  # environment.variables.LOCALE_ARCHIVE = lib.mkDefault "${pkgs.glibcLocales}/lib/locale/locale-archive";
}
