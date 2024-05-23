{pkgs, ...}: let
  vim-scratchpad = pkgs.writeShellScriptBin "vim-scratchpad" ''
    #!/usr/bin/env bash
    if [ -z "$1" ]; then
      nvim $(mktemp /tmp/tmp.XXXXXX)
    fi

    nvim $(mktemp /tmp/tmp.XXXXXX.$1)
  '';
in {
  # simple aliases that are compatible across all shells
  home.shellAliases = {
    v = "nvim";
    vs = "${vim-scratchpad}/bin/vim-scratchpad";

    ## Nix commands
    hm = "home-manager switch --flake /home/ethan/.dotfiles\\#$USER@$HOST";
    nr = "sudo nixos-rebuild switch --flake /home/ethan/.dotfiles\\#$HOST --impure";
    nrb = "sudo nixos-rebuild boot --flake /home/ethan/.dotfiles\\#$HOST";

    # Rebuild on remote
    nrd = "ssh -t ethan@nzxt \"cd /home/ethan/.dotfiles/; git pull; sudo nixos-rebuild switch --flake .#nzxt; exit; bash -l\"";
    # Rebuild remote on local
    nrdd = "nixos-rebuild switch --flake /home/ethan/.dotfiles#nzxt --target-host ethan@nzxt --use-remote-sudo";
    # List generations
    nlg = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
    # Delete old generations
    ndg = "sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old";
    # Collect garbage
    ncg = "nix-collect-garbage -d";
    nf = "nix flake";
    nsp = "nix-shell -p";
    nrw = "nix run .#watch";

    # My ip
    me = "xh -j ipinfo.io";
    ts = "tailscale";

    lsblk = "lsblk -o NAME,FSUSED,FSSIZE,FSUSE%";

    # hmc = "nvim \"+Man home-configuration.nix | only\"";
    hmc = "man home-configuration.nix";
    hmp = "home-manager packages | fzf";
    hlg = "home-manager generations";
    hdg = "home-manager expire-generations \"-1 minute\"";
  };
}
