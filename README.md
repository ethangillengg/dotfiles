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

## Thinkpad
- [x] Encrypted drive
- [ ] Fix Qt being slow
- [ ] Opt-in persistence
- [ ] Hyprland keybinding for [Super + Shit + Bracket]
