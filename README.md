# My NixOS Config

To install run the following commands in `$XDG_CONFIG_HOME`

```shell
git clone https://github.com/ethangillengg/dotfiles .dotfiles
nix shell nixpkgs#home-manager
sudo nixos-rebuild switch --flake .#HOSTNAME
home-manager switch --flake .#USERNAME@HOSTNAME
```

# TODO

- [ ] Hyprland keybinding for [Super + Shit + Bracket]

