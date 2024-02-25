{
  pkgs,
  lib,
  config,
  ...
}: let
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  pgrep = "${pkgs.procps}/bin/pgrep";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  swaymsg = "${config.wayland.windowManager.sway.package}/bin/swaymsg";

  isLocked = "${pgrep} -x swaylock";
  lockTime = 5 * 60;

  # Makes two timeouts: one for when the screen is not locked (lockTime+timeout) and one for when it is.
  afterLockTimeout = {
    timeout,
    command,
    resumeCommand ? null,
  }: [
    {
      timeout = lockTime + timeout;
      inherit command resumeCommand;
    }
    {
      command = "${isLocked} && ${command}";
      inherit resumeCommand timeout;
    }
  ];
in {
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";
    timeouts =
      [
        {
          # Lock screen
          timeout = lockTime;
          command = "${swaylock} --daemonize --grace 5";
        }
      ]
      ## Pause Mpris
      ++ (afterLockTimeout {
        timeout = 1;
        command = "${playerctl} pause";
      })
      ++
      # Mute mic
      (afterLockTimeout {
        timeout = 1;
        command = "${pamixer} --default-source --mute";
        resumeCommand = "${pamixer} --default-source --unmute";
      })
      ++
      # Turn off displays (sway)
      (lib.optionals config.wayland.windowManager.sway.enable (afterLockTimeout {
        timeout = 60;
        command = "${swaymsg} 'output * dpms off'";
        resumeCommand = "${swaymsg} 'output * dpms on'";
      }));
  };
}
