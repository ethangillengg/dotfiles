{
  config,
  pkgs,
  ...
}: let
  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btop = "${pkgs.btop}/bin/btop";
  hostname = "${pkgs.hostname}/bin/hostname";
  rofi = "${pkgs.rofi-wayland}/bin/rofi";
  nmtui = "${pkgs.networkmanager}/bin/nmtui";

  terminal = "${pkgs.wezterm}/bin/wezterm";
  terminal-spawn = cmd: "${terminal} -e $SHELL -i -c ${cmd}";

  systemMonitor = terminal-spawn btop;
  networkManager = terminal-spawn nmtui;

  # Function to simplify making waybar outputs
  jsonOutput = name: {
    pre ? "",
    text ? "",
    tooltip ? "",
    alt ? "",
    class ? "",
    percentage ? "",
  }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
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
in {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      primary = {
        mode = "dock";
        layer = "top";
        position = "top";
        height = 40;
        margin = "0";
        output = [
          "eDP-1"
          "DP-1"
          "DP-2"
        ];

        modules-left = [
          "custom/menu"
          "custom/hostname"
          "sway/workspaces"
          "sway/mode"
          "hyprland/workspaces"
        ];
        modules-center = [
          "cpu"
          "memory"
          # "disk"
          "clock"
          "temperature"
          "pulseaudio"
        ];

        modules-right = [
          "network"
          "battery#bat0"
          "battery#bat1"
          "tray"
        ];

        clock = {
          format = "{:%m/%d %I:%M %p}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>
          '';
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };
        };

        temperature = {
          thermal-zone = 5;
          format = "{icon}{temperatureC}°C";

          format-icons = ["" "" "" "" "" "" "" "" ""];
          interval = 3;
          on-click = systemMonitor;
        };

        cpu = {
          format = " {usage}%";
          # format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          interval = 3;
          on-click = systemMonitor;
        };

        memory = {
          format = " {used:0.1f}G";
          # format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          interval = 3;
          on-click = systemMonitor;
        };

        disk = {
          interval = 30;
          format = "󰋊 {used}";
          path = "/";
          on-click = systemMonitor;
        };

        "battery#bat0" = {
          bat = "BAT0";
          interval = 10;
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format = "{icon}{capacity}%";
          format-plugged = "󰂄{capacity}%";
          tooltip-format = "Battery 0";
        };
        "battery#bat1" = {
          bat = "BAT1";
          interval = 10;
          format-icons = ["󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format = "{icon}{capacity}%";
          format-plugged = "󰂄{capacity}%";
          tooltip-format = "Battery 1";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = ["" "" ""];
          };
          on-click = pavucontrol;
        };

        network = {
          interval = 3;
          format-wifi = " {essid}";
          format-ethernet = "󰈀 {essid}";
          format-disconnected = "";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = networkManager;
        };

        "custom/wgnord" = {
          interval = 10;
          return-type = "json";
          exec = jsonOutput "wgnord" {
            pre = ''status=$(sudo systemctl is-active --quiet wgnord && echo "connected" || echo "disconnected")'';
            alt = "$status";
            tooltip = "wgnord is $status";
          };

          format = "{icon} NordVPN";
          format-icons = {
            "connected" = "󰒘";
            "disconnected" = "󰦞";
          };
          on-click = "";
        };

        "custom/hostname" = {
          exec = "echo $USER@$(${hostname})";
        };

        "custom/menu" = {
          return-type = "json";
          exec = jsonOutput "menu" {
            text = " ";
            tooltip = ''$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2)'';
          };
          on-click = "${rofi} -S drun -x 10 -y 10 -W 25% -H 60%";
        };
      };
    };

    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = let
      inherit (config.colorscheme) colors;
    in
      /*
      css
      */
      ''
        * {
          font-size: 20px;
          font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
          padding: 0px 16px;
        }

        .modules-right {
          margin-right: -30px;
        }

        .modules-left {
          margin-left: -30px;
        }

        window#waybar.top {
          opacity: 0.95;
          padding: 0;
          background-color: #${colors.base00};
          border: 2px solid #${colors.base0C};
        }
        window#waybar.bottom {
          opacity: 0.90;
          background-color: #${colors.base00};
        }

        window#waybar {
          color: #${colors.base05};
        }


        #workpaces {
          margin: 0;
          padding: 0;
        }

        #workspaces button {
          background-color: #${colors.base00};
          color: #${colors.base05};
          padding: 2px 0px;
          margin: 2px 2px;
        }

        #workspaces button:hover {
            background: rgba(0, 0, 0, 0.2);
            border-bottom: 3px solid #${colors.base09};
        }

        #workspaces button.hidden {
          color: #${colors.base0C};
        }
        #workspaces button.focused,
        #workspaces button.active {
          color: #${colors.base09};
          border-bottom: 3px solid #${colors.base09};
        }

        #clock {
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding-left: 15px;
          padding-right: 15px;
          margin-top: 0;
          margin-bottom: 0;
        }

        #custom-menu {
          font-size: 28px;
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding-right: 8px;
          padding-left: 6px;
        }

        #custom-hostname {
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding-right: 18px;
          padding-left: 0px;
          margin-right: 0;
        }

        #custom-power {
          font-size: 24px;
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding: 0 18px;
        }

        #tray {
          color: #${colors.base05};
        }
      '';
  };
}
