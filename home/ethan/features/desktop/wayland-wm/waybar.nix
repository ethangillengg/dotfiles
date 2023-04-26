{ outputs, config, lib, pkgs, ... }:

let
  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  xml = "${pkgs.xmlstarlet}/bin/xml";
  # gamemoded = "${pkgs.gamemode}/bin/gamemoded";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  # playerctl = "${pkgs.playerctl}/bin/playerctl";
  # playerctld = "${pkgs.playerctl}/bin/playerctld";
  # neomutt = "${pkgs.neomutt}/bin/neomutt";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btop = "${pkgs.btop}/bin/btop";
  wofi = "${pkgs.wofi}/bin/wofi";
  # ikhal = "${pkgs.khal}/bin/ikhal";

  terminal = "${pkgs.wezterm}/bin/wezterm";
  terminal-spawn = cmd: "${terminal} -e $SHELL -i -c ${cmd}";

  # calendar = terminal-spawn ikhal;
  systemMonitor = terminal-spawn btop;
  # mail = terminal-spawn neomutt;

  # Function to simplify making waybar outputs
  jsonOutput = name: { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-${name}";
in
{
  programs.waybar = {
    enable = true;
    settings = {

      # secondary = {
      #   mode = "dock";
      #   layer = "top";
      #   height = 32;
      #   width = 100;
      #   margin = "4";
      #   position = "bottom";
      #   modules-center = (lib.optionals config.wayland.windowManager.sway.enable [
      #     "sway/workspaces"
      #     "sway/mode"
      #   ]) ++ (lib.optionals config.wayland.windowManager.hyprland.enable [
      #     "wlr/workspaces"
      #   ]);
      #
      #   "wlr/workspaces" = {
      #     on-click = "activate";
      #   };
      # };

      primary = {
        mode = "dock";
        layer = "top";
        position = "top";
        height = 40;
        # margin = "4 10 10 0";
        margin = "0";
        output = [
          "eDP-1"
          "DP-2"
        ];

        modules-left = [
          "custom/menu"
          "custom/hostname"
          # "custom/currentplayer"
          # "custom/player"
        ];
        modules-center = [
          "cpu"
          # "custom/gpu"
          "memory"
          "clock"
          "pulseaudio"
          # "custom/unread-mail"
          # "custom/gammastep"
          # "custom/gpg-agent"
        ];

        modules-right = [
          # "custom/gamemode"
          "network"
          # "custom/tailscale-ping"
          "battery#bat0"
          "battery#bat1"
          # "tray"
        ];

        clock = {
          format = "{:%d/%m %H:%M}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          # on-click = calendar;
        };

        cpu = {
          format = "   {usage}%";
          on-click = systemMonitor;
        };

        memory = {
          format = "  {}%";
          interval = 5;
          on-click = systemMonitor;
        };

        "battery#bat0" = {
          bat = "BAT0";
          interval = 10;
          format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
          format = "{icon} {capacity}%";
          format-plugged = " {capacity}%";
          tooltip-format = "Battery 0";
        };
        "battery#bat1" = {
          bat = "BAT1";
          interval = 10;
          format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
          format = "{icon} {capacity}%";
          format-plugged = " {capacity}%";
          tooltip-format = "Battery 1";
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "";
            headset = "";
            portable = "";
            default = [ "" "" "" ];
          };
          on-click = pavucontrol;
        };

        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = " Connected";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = "";
        };


        "custom/hostname" = {
          exec = "echo $USER@$(hostname)";
          on-click = "${wofi} -S drun -x 10 -y 10 -W 25% -H 60%";
          tooltip = ''$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2)'';
        };

        "custom/menu" = {
          return-type = "json";
          exec = jsonOutput "menu" {
            text = " ";
            tooltip = ''$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2)'';
          };
          on-click = "${wofi} -S drun -x 10 -y 10 -W 25% -H 60%";
        };
      };
    };

    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = let inherit (config.colorscheme) colors; in /* css */ ''
       * {
        font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
        font-size: 20px;
        padding: 0px 16px;
      }
    
      .modules-right {
        margin-left: -30px;
      }
    
      .modules-left {
        margin-left: -30px;
      }
    
      window#waybar.top {
        opacity: 0.95;
        padding: 0;
        background-color: #${colors.base00};
        /* border: 2px solid #${colors.base0C};  */
        /* border-radius: 4px; */
      }
      window#waybar.bottom {
        opacity: 0.90;
        background-color: #${colors.base00};
        border: 0px solid #${colors.base0C};
        border-radius: 4px;
      }
    
      window#waybar {
        color: #${colors.base05};
      }
    
      #workspaces button {
        background-color: #${colors.base01};
        color: #${colors.base05};
        margin: 4px;
      }
      #workspaces button.hidden {
        background-color: #${colors.base00};
        color: #${colors.base04};
      }
      #workspaces button.focused,
      #workspaces button.active {
        background-color: #${colors.base0A};
        color: #${colors.base00};
      }
    
      #clock {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding-left: 15px;
        padding-right: 15px;
        margin-top: 0;
        margin-bottom: 0;
        /* border-radius: 4px; */
      }
    
      #custom-menu {
        font-size: 28px;
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding-right: 8px;
        padding-left: 6px;
        /* border-radius: 4px 0 0 4px;  */
      }
    
      #custom-hostname {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding-right: 18px;
        padding-left: 0px;
        /* border-radius: 0 4px 4px 0;  */
      }
    
      #tray {
        color: #${colors.base05};
      } 
    '';
  };

}