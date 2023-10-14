{
  config,
  pkgs,
  ...
}: let
  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  # xml = "${pkgs.xmlstarlet}/bin/xml";
  # gamemoded = "${pkgs.gamemode}/bin/gamemoded";
  # systemctl = "${pkgs.systemd}/bin/systemctl";
  # journalctl = "${pkgs.systemd}/bin/journalctl";
  # playerctl = "${pkgs.playerctl}/bin/playerctl";
  # playerctld = "${pkgs.playerctl}/bin/playerctld";waybar
  # neomutt = "${pkgs.neomutt}/bin/neomutt";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btop = "${pkgs.btop}/bin/btop";
  rofi = "${pkgs.rofi-wayland}/bin/rofi";
  cava = "${pkgs.cava}/bin/cava";
  nmtui = "${pkgs.networkmanager}/bin/nmtui";

  terminal = "${pkgs.wezterm}/bin/wezterm";
  terminal-spawn = cmd: "${terminal} -e $SHELL -i -c ${cmd}";

  # calendar = terminal-spawn ikhal;
  systemMonitor = terminal-spawn btop;
  networkManager = terminal-spawn nmtui;
  # mail = terminal-spawn neomutt;

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
        margin = "2 4";
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
          "temperature"
          "cpu"
          "memory"
          "disk"
          "clock"
          "pulseaudio"
          # "cava"
          # "custom/unread-mail"
          # "custom/gammastep"
          # "custom/gpg-agent"
        ];

        modules-right = [
          # "custom/wgnord"
          "network"
          # "custom/tailscale-ping"
          "battery#bat0"
          "battery#bat1"
          "tray"
          "custom/power"
        ];

        clock = {
          format = "{:%d/%m %I:%M %p}";
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
          # on-click = calendar;
        };

        temperature = {
          thermal-zone = 5;
          # "hwmon-path": "/sys/class/hwmon/hwmon2/temp1_input",
          # critical-threshold = 85;
          # format-critical = "{temperatureC}°C";
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

        cava = {
          # cava_config= "$XDG_CONFIG_HOME/cava/cava.conf",
          framerate = 60;
          autosens = 1;
          sensitivity = 100;
          bars = 20;
          lower_cutoff_freq = 50;
          higher_cutoff_freq = 10000;
          method = "pipewire";
          source = "auto";
          stereo = true;
          reverse = false;
          bar_delimiter = 0;
          monstercat = false;
          waves = false;
          noise_reduction = 0.77;
          input_delay = 2;
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          # actions= {
          #            on-click-right= "mode"
          #            }
        };

        "battery#bat0" = {
          bat = "BAT0";
          interval = 10;
          # format-icons = [ "" "" "" "" "" "" "" "" "" "" ];
          # format-icons = ["󱃍" "󱊡" "󱊢" "󱊣"];
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

        "custom/power" = {
          exec = "echo '󰐥'";
          on-click = "poweroff";
        };

        "custom/hostname" = {
          exec = "echo $USER@$(hostname)";
          on-click = "${rofi} -S drun -x 10 -y 10 -W 25% -H 60%";
          tooltip = ''$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2)'';
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
          border-radius: 4px;
        }
        window#waybar.bottom {
          opacity: 0.90;
          background-color: #${colors.base00};
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
          border-radius: 4px;
        }

        #custom-menu {
          font-size: 28px;
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding-right: 8px;
          padding-left: 6px;
          border-radius: 4px 0 0 4px;
        }

        #custom-hostname {
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding-right: 18px;
          padding-left: 0px;
        }

        #custom-power {
          font-size: 24px;
          background-color: #${colors.base0C};
          color: #${colors.base00};
          padding: 0 18px;
          border-radius: 0 4px 4px 0;
        }

        #tray {
          color: #${colors.base05};
        }
      '';
  };
}
