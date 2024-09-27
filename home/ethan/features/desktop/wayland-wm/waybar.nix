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
  ncmpcpp = "${pkgs.ncmpcpp}/bin/ncmpcpp";
  random-wallpaper = "${pkgs.random-wallpaper}/bin/random-wallpaper";
  sptlrx = "${pkgs.sptlrx}/bin/sptlrx";

  terminal = "${pkgs.wezterm}/bin/wezterm";
  terminal-spawn = cmd: "${terminal} -e $SHELL -i -c ${cmd}";

  systemMonitor = terminal-spawn btop;
  musicPlayer = terminal-spawn ncmpcpp;
  lyricsViewer = terminal-spawn sptlrx;

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
          "DP-3"
          "DP-4"
          "DP-5"
          "DP-6"
          "HDMI-A-1"
          "HDMI-A-2"
        ];

        modules-left = [
          "custom/menu"
          "sway/workspaces"
          "hyprland/workspaces"
          "cava"
          "mpris"
          "sway/mode"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "pulseaudio"
          "backlight"
          "battery"
          "battery#BAT1"
          "cpu"
          "network"
        ];

        clock = {
          # 20/12/2020 10:00 AM
          format = "{:%m/%d %I:%M %p}";
          # 10:00 AM Monday Dec 20
          # format = "{:%I:%M %p  %A %b %d}";
          # 10:00 AM Mon Dec 20
          # format = "{:%I:%M %p  %a %b %d}";
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

        temperature = {
          thermal-zone = 5;
          format = "{icon}{temperatureC}°C";

          format-icons = ["" "" "" "" "" "" "" "" ""];
          interval = 3;
          on-click = systemMonitor;
        };

        "sway/workspaces" = {
          format = "{icon}";
          format-icons = {
            "0: email" = "󰇮 ";
          };
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
          format = "{dynamic}";
          format-paused = "{status_icon} <i>{dynamic}</i>";
          tooltip-format = "{title} - {artist} ({position}/{length})";
          dynamic-order = ["title" "artist"];
          artist-len = 12;
          title-len = 20;
          dynamic-len = 32;
          dynamic-importance-order = ["title" "artist"];
          status-icons = {
            paused = "󰏤";
          };
          on-click-right = musicPlayer;
          on-click-middle = lyricsViewer;
        };

        cava = {
          sleep_timer = 3; # Seconds with no input before cava main thread goes to sleep mode
          hide_on_silence = true; # Hides the widget if no input is present (after sleep_timer elapsed)
          method = "pipewire";
          bars = 10;
          format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          bar_delimiter = 0;
          input_delay = 0;
        };

        disk = {
          interval = 30;
          format = "󰋊 {used}";
          path = "/";
          on-click = systemMonitor;
        };

        battery = {
          bat = "BAT0";
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

          weighted-average = false; # average battery percentage across all batteries
          # full-at = 80; # since we stop charging at 80% to preserve battery life
          interval = 15;
        };
        "battery#BAT1" = {
          bat = "BAT1";
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

          weighted-average = false; # average battery percentage across all batteries
          # full-at = 80; # since we stop charging at 80% to preserve battery life
          interval = 15;
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

        backlight = {
          format = "󰃠 {percent}%";
        };

        network = {
          interval = 1;
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

        "custom/lyrics" = {
          exec = "${sptlrx} pipe";
          on-click = lyricsViewer;
          max-length = 40;
          format = "<i>{}</i>";
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

          on-click = random-wallpaper;
        };
      };
    };

    # Cheatsheet:
    # x -> all sides
    # x y -> vertical, horizontal
    # x y z -> top, horizontal, bottom
    # w x y z -> top, right, bottom, left
    style = let
      inherit (config.colorscheme) palette;
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
          background-color: #${palette.base00};
          border: 2px solid #${palette.base0C};
        }

        window#waybar {
          color: #${palette.base05};
        }

        #workspaces {
          border-radius: 0px;
          padding-left: 0px;
          padding: 0px;
        }
        #workspaces button {
          border-radius: 0px;
          padding: 0px;
          color: #${palette.base05};
        }
        #workspaces button.focused,
        #workspaces button.active {
          background-color: #${palette.base0C};
          color: #${palette.base00};
        }
        #workspaces button:hover {
          border-radius: 0px;
          background-color: #${palette.base09};
          color: #${palette.base00};
        }

        #cpu {
          color: #${palette.base0D};
        }

        #custom-lyrics {
          color: #${palette.base04};
        }
        #mpris {
          /* color: #${palette.base04}; */
        }

        #backlight{
          color: #${palette.base0A};
        }

        #pulseaudio {
          color: #${palette.base0E};
        }


        #temperature {
          color: #${palette.base0C};
        }

        #battery
        {
          color: #${palette.base0B};
        }
        #battery.discharging.warning {
          color: #${palette.base09};
        }
        #battery.discharging.critical {
          color: #${palette.base08};
        }

        #custom-power {
          color: #${palette.base08};
        }

        #clock {
          color: #${palette.base05};
          padding: 0px 16px;
          margin-top: 0;
          margin-bottom: 0;
        }

        #custom-menu {
          font-size: 26px;
          color: #${palette.base0C};
        }

        #tray {
          margin-right: 6px;
          color: #${palette.base05};
        }
      '';
  };
}
