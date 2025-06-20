{
  pkgs,
  lib,
  config,
  ...
}: {
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc # google ime
          fcitx5-gtk
          libsForQt5.fcitx5-qt
        ];
      };
    };
  };

  # workaround for fcitx5 expecting a writeable config file
  # see: https://github.com/nix-community/home-manager/issues/3090#issuecomment-1799268943
  xdg.configFile.fcitx5.source = ./config;

  # only if sway is enabled
  wayland.windowManager.sway.config.startup = [
    (lib.optionals
      config.wayland.windowManager.sway.enable
      {command = "fcitx5";})
  ];
}
