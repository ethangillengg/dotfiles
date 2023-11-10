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
- [x] Switch to zsh
- [x] Brightness like [this](https://www.reddit.com/r/unixporn/comments/d0lxbf/sway_symbolic_links_save_lives_pywal_mako/)
- [x] fix betterbird no emails showing
- [x] Float calculator
- [ ] Check out khal?
- [ ] notifications show on fullscreen
- [ ] fix slow link opening
- [ ] youtube music qutebrowser
- [ ] consistent keybindings qute and neovim
- [ ] Swaykiosk
- [ ] Passthrough mute to discord

## Thinkpad

- [x] Encrypted drive
- [x] Fix Qt being slow
- [x] Fix discord screensharing
- [x] Hyprland keybinding for [Super + Shit + Bracket]
- [x] Fix tailscale and wifi
- [ ] Opt-in persistence
