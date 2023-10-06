{
  # simple aliases that are compatible across all shells
  home.shellAliases = {
    v = "nvim";
    vi = "nvim";
    vim = "nvim";

    hm = "home-manager switch --flake /home/ethan/.dotfiles#ethan@thinkpad -j 4";
    nr = "sudo nixos-rebuild switch --flake /home/ethan/.dotfiles#thinkpad";
    nrb = "sudo nixos-rebuild boot --flake /home/ethan/.dotfiles#thinkpad";
    nrd = "ssh -t ethan@nzxt \"cd /home/ethan/.dotfiles/; git pull; sudo nixos-rebuild switch --flake .#nzxt; exit; bash -l\"";
    nrdd = "nixos-rebuild switch --flake /home/ethan/.dotfiles#nzxt --target-host ethan@nzxt --use-remote-sudo";

    #My ip
    me = "xh -j ipinfo.io";

    lsblk = "lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS,UUID";
    llama-cpp = "nix run github:ggerganov/llama.cpp --";

    # hmc = "nvim \"+Man home-configuration.nix | only\"";
    hmc = "man home-configuration.nix";
    hmp = "home-manager packages | fzf";
  };
}
