{
  config,
  pkgs,
  ...
}: let
  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  wpa-gui = "${pkgs.wpa_supplicant_gui}/bin/wpa_gui";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btop = "${pkgs.btop}/bin/btop";
  rofi = "${pkgs.rofi-wayland}/bin/rofi";
  mpc = "${pkgs.mpc-cli}/bin/mpc";
  ncmpcpp = "${pkgs.ncmpcpp}/bin/ncmpcpp";

  wallpaper = config.wallpaper;
  lock = "${config.programs.swaylock.package}/bin/swaylock --clock -f -i ${wallpaper} --scaling fill -F";

  terminal = "${pkgs.wezterm}/bin/wezterm";
  terminal-spawn = cmd: "${terminal} -e $SHELL -i -c ${cmd}";

  systemMonitor = terminal-spawn btop;
  musicPlayer = terminal-spawn ncmpcpp;

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
          "HDMI-A-2"
        ];

        modules-left = [
          "custom/menu"
          "sway/workspaces"
          "hyprland/workspaces"
          # "temperature"
          "mpris"
          "cava"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "sway/mode"
          "tray"
          "pulseaudio"
          "battery"
          "cpu"
          "network"
          "group/group-power"
        ];

        clock = {
          # 20/12/2020 10:00 AM
          # format = "{:%m/%d %I:%M %p}";
          # Monday Dec 20  10:00 AM
          format = "{:%I:%M %p  %A %b %d}";
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

        tray = {
          icon-size = 15;
          spacing = 0;
        };

        "group/group-power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 200;
            children-class = "not-power";
            transition-left-to-right = false;
          };
          modules = [
            "custom/power" # First element is the "group leader" and won't ever be hidden
            "custom/reboot"
            "custom/quit"
            "custom/lock"
          ];
        };
        "custom/quit" = {
          format = "󰍃";
          tooltip = false;
          on-click = "swaymsg exit; systemctl --user stop sway-session.target";
        };
        "custom/lock" = {
          format = "󰍁";
          tooltip = false;
          on-click = "${lock}";
        };
        "custom/reboot" = {
          format = "";
          tooltip = false;
          on-click = "reboot";
        };
        "custom/power" = {
          format = "";
          tooltip = false;
          on-click = "shutdown now";
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
          interval = 3;
          on-click = systemMonitor;
        };

        memory = {
          format = " {used:0.1f}G";
          interval = 3;
          on-click = systemMonitor;
        };

        mpris = {
          format = "<i>{status_icon} {dynamic}</i>";
          tooltip-format = "{title} - {artist} ({position}/{length})";
          dynamic-order = ["title" "artist"];
          artist-len = 12;
          title-len = 20;
          dynamic-len = 22;
          dynamic-importance-order = ["title" "artist"];
          status-icons = {
            playing = "";
            paused = "󰏤";
            stopped = "󰓛";
          };
        };

        cava = {
          sleep_timer = 5; # Seconds with no input before cava main thread goes to sleep mode
          hide_on_silence = true; # Hides the widget if no input is present (after sleep_timer elapsed)
          method = "pipewire";
          bars = 12;
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          bar_delimiter = 0;
          input_delay = 0;
          actions = {
            on-click-right = "mode";
          };
        };

        disk = {
          interval = 30;
          format = "󰋊 {used}";
          path = "/";
          on-click = systemMonitor;
        };

        battery = {
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format = "{icon}{capacity}%";
          format-charging = "󰂄{capacity}%";
          format-plugged = "󰂏{capacity}%"; # when fully charged
          tooltip-format = "{timeTo}\nRate: {power}W";

          states = {
            warning = 25;
            critical = 10;
          };
          format-warning = "󰂃{capacity}%";
          format-critical = "󰂃{capacity}%";

          weighted-average = true; # average battery percentage across all batteries
          full-at = 80; # since we stop charging at 80% to preserve battery life
          interval = 3;
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
          on-click = wpa-gui;
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
          font-size: 18px;
          font-family: ${config.fontProfiles.regular.family}, ${config.fontProfiles.monospace.family};
          padding: 0 12px;
        }

        /* This is a hack to fix the tray icon being cut off */
        .modules-right {
          margin-right: -16px;
        }
        .modules-left {
          margin-left: -16px;
        }


        window#waybar.top {
          padding: 0;
          background-color: #${colors.base00};
          border: 2px solid #${colors.base0C};
        }

        window#waybar {
          color: #${colors.base05};
        }

        #workspaces {
          border-radius: 0px;
          padding-left: 0px;
          padding: 0px;
        }
        #workspaces button {
          padding: 0px;
          color: #${colors.base05};
        }
        #workspaces button.focused,
        #workspaces button.active {
          background-color: #${colors.base0C};
          color: #${colors.base00};
        }
        #workspaces button:hover {
          border-radius: 0px;
          background-color: #${colors.base09};
          color: #${colors.base00};
        }



        #cpu {
          color: #${colors.base0A};
        }

        #mpris {
          color: #${colors.base04};
        }

        #pulseaudio {
          color: #${colors.base0E};
        }

        #temperature {
          color: #${colors.base0C};
        }

        #battery
        {
          color: #${colors.base0B};
        }
        #battery.discharging.warning {
          color: #${colors.base09};
        }
        #battery.discharging.critical {
          color: #${colors.base08};
        }

        #custom-power {
          color: #${colors.base08};
        }

        #clock {
          color: #${colors.base05};
          padding: 0px 16px;
          margin-top: 0;
          margin-bottom: 0;
        }

        #custom-menu {
          font-size: 26px;
          color: #${colors.base0C};
        }

        #tray {
          margin-right: 6px;
          color: #${colors.base05};
        }
      '';
  };
}
