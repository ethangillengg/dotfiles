{
  pkgs,
  lib,
  config,
  ...
}: let
  homeCfgs = config.home-manager.users;
  homeSharePaths = lib.mapAttrsToList (_: v: "${v.home.path}/share") homeCfgs;
  vars = ''XDG_DATA_DIRS="$XDG_DATA_DIRS:${lib.concatStringsSep ":" homeSharePaths}" GTK_USE_PORTAL=0'';

  ethanCfg = homeCfgs.ethan;
  gtkTheme = ethanCfg.gtk.theme;
  iconTheme = ethanCfg.gtk.iconTheme;
  wallpaper = ethanCfg.wallpaper;

  sway-kiosk = command: "${lib.getExe pkgs.sway} --config ${pkgs.writeText "kiosk.config" ''
    output * bg #000000 solid_color
    xwayland disable
    input "type:touchpad" {
      tap enabled
    }
    exec '${vars} ${command}; ${pkgs.sway}/bin/swaymsg exit'
  ''}";
in {
  users.extraUsers.greeter = {
    packages = [
      gtkTheme.package
      iconTheme.package
    ];
    # For caching and such
    home = "/tmp/greeter-home";
    createHome = true;
  };

  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        icon_theme_name = "Papirus";
        theme_name = gtkTheme.name;
      };
      background = {
        path = wallpaper;
        fit = "Cover";
      };
      env = {
        SESSION_DIRS = "/etc/greetd/environments";
      };
    };
  };
  services.greetd = {
    enable = true;
    settings.default_session.command = sway-kiosk (lib.getExe config.programs.regreet.package);
  };

  environment.etc."greetd/environments".text = ''
    sway
  '';

  services.displayManager.sddm.enable = lib.mkForce false;
  services.xserver.displayManager.lightdm.enable = lib.mkForce false;
  services.xserver.displayManager.gdm.enable = lib.mkForce false;
}
