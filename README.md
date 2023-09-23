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

- [ ] Factor out generic host settings
- [ ] password-store
- [ ] Check out khal?

## Thinkpad

- [x] Encrypted drive
- [x] Fix Qt being slow
- [x] Fix discord screensharing
- [ ] Opt-in persistence
- [ ] Hyprland keybinding for [Super + Shit + Bracket]
