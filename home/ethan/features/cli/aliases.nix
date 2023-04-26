{
  # simple aliases that are compatible across all shells
  home.shellAliases = {
    ll = "lsd -l";
    lt = "lsd -l --tree --depth=4";
    la = "lsd -lA";
    lz = "lsd -l --total-size";

    v = "nvim";
    vi = "nvim";
    vim = "nvim";

    ga = "git add .";
    lg = "gitui";

    hm = "home-manager switch --flake /home/ethan/.dotfiles#ethan@thinkpad -j 4";
    nr = "sudo nixos-rebuild switch --flake /home/ethan/.dotfiles#thinkpad";
    nrd = "nixos-rebuild switch --flake /home/ethan/.dotfiles#nzxt --target-host ethan@nzxt --use-remote-sudo";


    #My ip
    me = "xh -j ipinfo.io";

    #manga reader
    mr = "feh -FZ --cache-size 2048 --on-last-slide hold --font \"yudit/40\" --scroll-step 50 --info \"echo %u/%l\" $argv; ";

    lsblk = "lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS,UUID";

    # hmc = "nvim \"+Man home-configuration.nix | only\"";
    hmc = "man home-configuration.nix";
    hmp = "home-manager packages | fzf";
  };
}
