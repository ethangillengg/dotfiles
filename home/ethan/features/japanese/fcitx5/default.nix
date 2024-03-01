{
  pkgs,
  lib,
  config,
  ...
}: {
  i18n = {
    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc # google ime
          fcitx5-gtk
          libsForQt5.fcitx5-qt
        ];
      };
    };
  };

  xdg.configFile."fcitx5" = {
    source = ./config;
    recursive = true;
  };

  # only if sway is enabled
  wayland.windowManager.sway.config.startup = [
    (lib.optionals
      config.wayland.windowManager.sway.enable
      {command = "fcitx5";})
  ];
}
