{
  pkgs,
  config,
  ...
}: let
  swayConfig = config.wayland.windowManager.sway.config;
  modifier = swayConfig.modifier;
  innerGap = toString swayConfig.gaps.inner;
  outerGap = toString swayConfig.gaps.outer;

  toggleZenMode = pkgs.writeShellScriptBin "toggleZenMode" ''
    #!/usr/bin/env bash

    # toggle_gaps [on|off|toggle]

    INNER=$1
    OUTER=$2

    # Get current workspace.
    workspace=$(swaymsg -t get_workspaces -r \
            | jq -r '.[] | if .["focused"] then .["name"] else empty end')
    # Get current inner gap size. (0 means default)
    inner_gaps=$(swaymsg -t get_tree -r \
            | jq -r 'recurse(.nodes[]; .nodes != null) | if .type == "workspace" and .name == "'"$workspace"'" then .rect.x else empty end')

    if [[   "$inner_gaps" == 0 ]]; then
        mode="off"
    else
        mode="on"
    fi

    if [[ "$mode" == "off" ]]; then
        swaymsg "gaps inner current set $INNER; gaps outer current set $OUTER"
    else
        swaymsg "gaps inner current set 0; gaps outer current set 0"
    fi
  '';
in {
  home.packages = [
    toggleZenMode
  ];
  wayland.windowManager.sway.config.keybindings = {
    "${modifier}+apostrophe" = "exec ${toggleZenMode}/bin/toggleZenMode ${innerGap} ${outerGap}";
    ## Toggle Waybar
    "${modifier}+b" = "exec pkill -SIGUSR1 -x .waybar-wrapped";
    ## Reload Waybar
    "${modifier}+Shift+b" = "exec pkill -SIGUSR2 -x .waybar-wrapped";
  };
}
