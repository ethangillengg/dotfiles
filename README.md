# My NixOS Config

To install run the following commands in `$XDG_CONFIG_HOME`

```shell
git clone https://github.com/ethangillengg/dotfiles .dotfiles
nix shell nixpkgs#home-manager
sudo nixos-rebuild switch --flake .#HOSTNAME
home-manager switch --flake .#USERNAME@HOSTNAME
```

# TODO

## General

- [x] Factor out generic host settings
- [x] password-store
- [x] Check out yazi instead of lf
- [x] Fix `yt-music` opening in a floating window on hyprland
- [ ] Check out khal?
- [ ] hyprland gamemode
- [ ] notifications show on fullscreen
- [ ] waybar hover tooltip in hyprland
- [ ] fix slow link opening
- [ ] fix betterbird no emails showing
- [ ] youtube music qutebrowser
- [ ] consistent keybindings qute and neovim
- [ ] bash?
- [ ] [Brightness like this](https://www.reddit.com/r/unixporn/comments/d0lxbf/sway_symbolic_links_save_lives_pywal_mako/)

## Thinkpad

- [x] Encrypted drive
- [x] Fix Qt being slow
- [x] Fix discord screensharing
- [x] Hyprland keybinding for [Super + Shit + Bracket]
- [ ] Fix tailscale and wifi
- [ ] Opt-in persistence
