{
  config,
  pkgs,
  ...
}: let
  inherit (config.colorscheme) variant palette;
  rofi = "${pkgs.rofi}/bin/rofi";
  wezterm = "${pkgs.wezterm}/bin/wezterm";
in {
  xdg.mimeApps.defaultApplications = {
    "text/html" = ["org.qutebrowser.qutebrowser.desktop"];
    "text/xml" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/http" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/https" = ["org.qutebrowser.qutebrowser.desktop"];
    "x-scheme-handler/qute" = ["org.qutebrowser.qutebrowser.desktop"];
  };

  programs.qutebrowser = {
    enable = true;
    loadAutoconfig = true;
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      d = "https://www.merriam-webster.com/dictionary/{}";

      gh = "https://github.com/search?q={}";
      ghr = "https://github.com/{}";
      yt = "https://www.youtube.com/results?search_query={}";
      aw = "https://wiki.archlinux.org/?search={}";
      nw = "https://nixos.wiki/index.php?search={}";
      np = "https://search.nixos.org/packages?channel=unstable&query={}";
      no = "https://search.nixos.org/options?channel=unstable&query={}";
      ngh = "https://github.com/search?q=lang%3Anix+{}";
      nyaa = "https://nyaa.si/?f=0&c=0_0&s=seeders&o=desc&q={}";
    };
    keyBindings = {
      normal = {
        ## Password-store integration
        # try to fill username / password
        ",l" = "spawn --userscript qute-pass -U secret -u \"login: (.+)\" -d \"tofi\"";
        # try to query for username/password
        ",pq" = "spawn --userscript qute-pass -U secret -u \"login: (.+)\" --unfiltered -d \"${rofi} --dmenu\"";
        # try to fill password only
        ",pp" = "spawn --userscript qute-pass -U secret -u \"login: (.+)\" --password-only -d \"${rofi} --dmenu\"";
        # try to fill username only
        ",pu" = "spawn --userscript qute-pass -U secret -u \"login: (.+)\" --username-only -d \"${rofi} --dmenu\"";
        # try to fill otp only
        ",po" = "spawn --userscript qute-pass -U secret -u \"login: (.+)\" --otp-only -d \"${rofi} --dmenu\"";
        ## MPV
        ",m" = "hint links spawn umpv {hint-url}";
        ";m" = "hint --rapid links spawn umpv {hint-url}";
        # open current url
        ",M" = "spawn umpv {url}";

        "cm" = "clear-messages";
        "<Ctrl-c>" = "yank selection";
        "<Ctrl-r>" = "edit-url";
        "<Ctrl-e>" = "edit-text";
        "J" = "nop";
        "K" = "nop";
        "L" = "tab-next";
        "H" = "tab-prev";

        "gL" = "tab-move +";
        "gH" = "tab-move -";

        "<Ctrl-h>" = "back";
        "<Ctrl-l>" = "forward";
      };
    };
    settings = {
      content.javascript.clipboard = "access";
      qt.force_platform = "wayland";
      tabs.show = "multiple";

      url = {
        # Default page when opening new tab
        default_page = "qute://start/";
        # Default pages on startup
        start_pages = ["qute://start/"];
        open_base_url = true;
      };
      downloads = {
        # Don't prompt, just download to ~/Downloads
        location = {
          prompt = false;
          suggestion = "both";
        };
      };
      editor = {
        command = [
          # Open nvim in a new wezterm window
          wezterm
          "start"
          "--always-new-process"
          "-e"
          "nvim"
          # Edit new file with .md extension
          "{file}.md"
          # Go to same position as in qutebrowser
          "-c"
          "normal {line}G{column0}l"
          # Link qute temp file with .md file
          "-c"
          ":silent exec '!ln {file} {file}.md'"
          # Reload the file to get new contents after linking
          "-c"
          ":e"
        ];
      };
      fonts = {
        default_family = config.fontProfiles.regular.family;
        default_size = "12pt";
      };
      colors = {
        webpage.preferred_color_scheme = variant;
        completion = {
          fg = "#${palette.base05}";
          match.fg = "#${palette.base09}";
          even.bg = "#${palette.base00}";
          odd.bg = "#${palette.base00}";
          scrollbar = {
            bg = "#${palette.base00}";
            fg = "#${palette.base05}";
          };
          category = {
            bg = "#${palette.base00}";
            fg = "#${palette.base0D}";
            border = {
              bottom = "#${palette.base00}";
              top = "#${palette.base00}";
            };
          };
          item.selected = {
            bg = "#${palette.base02}";
            fg = "#${palette.base05}";
            match.fg = "#${palette.base05}";
            border = {
              bottom = "#${palette.base02}";
              top = "#${palette.base02}";
            };
          };
        };
        contextmenu = {
          disabled = {
            bg = "#${palette.base08}";
            fg = "#${palette.base04}";
          };
          menu = {
            bg = "#${palette.base00}";
            fg = "#${palette.base05}";
          };
          selected = {
            bg = "#${palette.base02}";
            fg = "#${palette.base05}";
          };
        };
        downloads = {
          bar.bg = "#${palette.base00}";
          error.fg = "#${palette.base08}";
          start = {
            bg = "#${palette.base0D}";
            fg = "#${palette.base00}";
          };
          stop = {
            bg = "#${palette.base0C}";
            fg = "#${palette.base00}";
          };
        };
        hints = {
          bg = "#${palette.base0A}";
          fg = "#${palette.base00}";
          match.fg = "#${palette.base05}";
        };
        keyhint = {
          bg = "#${palette.base00}";
          fg = "#${palette.base05}";
          suffix.fg = "#${palette.base05}";
        };
        messages = {
          error.bg = "#${palette.base08}";
          error.border = "#${palette.base08}";
          error.fg = "#${palette.base00}";
          info.bg = "#${palette.base00}";
          info.border = "#${palette.base00}";
          info.fg = "#${palette.base05}";
          warning.bg = "#${palette.base0E}";
          warning.border = "#${palette.base0E}";
          warning.fg = "#${palette.base00}";
        };
        prompts = {
          bg = "#${palette.base00}";
          fg = "#${palette.base05}";
          border = "#${palette.base00}";
          selected.bg = "#${palette.base02}";
        };
        statusbar = {
          caret.bg = "#${palette.base00}";
          caret.fg = "#${palette.base0D}";
          caret.selection.bg = "#${palette.base00}";
          caret.selection.fg = "#${palette.base0D}";
          command.bg = "#${palette.base01}";
          command.fg = "#${palette.base04}";
          command.private.bg = "#${palette.base01}";
          command.private.fg = "#${palette.base0E}";
          insert.bg = "#${palette.base00}";
          insert.fg = "#${palette.base0C}";
          normal.bg = "#${palette.base00}";
          normal.fg = "#${palette.base05}";
          passthrough.bg = "#${palette.base00}";
          passthrough.fg = "#${palette.base0A}";
          private.bg = "#${palette.base00}";
          private.fg = "#${palette.base0E}";
          progress.bg = "#${palette.base0D}";
          url.error.fg = "#${palette.base08}";
          url.fg = "#${palette.base05}";
          url.hover.fg = "#${palette.base09}";
          url.success.http.fg = "#${palette.base0B}";
          url.success.https.fg = "#${palette.base0B}";
          url.warn.fg = "#${palette.base0E}";
        };
        tabs = {
          bar.bg = "#${palette.base00}";
          even.bg = "#${palette.base00}";
          even.fg = "#${palette.base05}";
          indicator.error = "#${palette.base08}";
          indicator.start = "#${palette.base0D}";
          indicator.stop = "#${palette.base0C}";
          odd.bg = "#${palette.base00}";
          odd.fg = "#${palette.base05}";
          pinned.even.bg = "#${palette.base0B}";
          pinned.even.fg = "#${palette.base00}";
          pinned.odd.bg = "#${palette.base0B}";
          pinned.odd.fg = "#${palette.base00}";
          pinned.selected.even.bg = "#${palette.base02}";
          pinned.selected.even.fg = "#${palette.base05}";
          pinned.selected.odd.bg = "#${palette.base02}";
          pinned.selected.odd.fg = "#${palette.base05}";
          selected.even.bg = "#${palette.base02}";
          selected.even.fg = "#${palette.base05}";
          selected.odd.bg = "#${palette.base02}";
          selected.odd.fg = "#${palette.base05}";
        };
      };
    };
    extraConfig = ''
      c.tabs.padding = {"bottom": 6, "left": 6, "right": 6, "top": 6}
    '';
  };
}
