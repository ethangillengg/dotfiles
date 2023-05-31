{pkgs, ...}: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gtk/settings/file-chooser" = {
      clock-format = "24h";
    };
    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 6;
    };
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>w"];
      switch-to-workspace-left = ["<Super>bracketleft"];
      switch-to-workspace-right = ["<Super>bracketright"];
      move-to-workspace-left = ["<Shift><Super>bracketleft"];
      move-to-workspace-right = ["<Shift><Super>bracketright"];
      switch-to-workspace-1 = ["<Super>1"];
      move-to-workspace-1 = ["<Shift><Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      move-to-workspace-4 = ["<Shift><Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      move-to-workspace-5 = ["<Shift><Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      move-to-workspace-6 = ["<Shift><Super>6"];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "wezterm";
      name = "start terminal";
    };
  };
}
