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

    hm = "home-manager switch --flake /home/ethan/.dotfiles#ethan@thinkpad";
    nr = "sudo nixos-rebuild switch --flake /home/ethan/.dotfiles#thinkpad";

    #manga reader
    mr = "feh -FZ --cache-size 2048 --on-last-slide hold --font \"yudit/40\" --scroll-step 50 --info \"echo %u/%l\" $argv; ";

    lsblk = "lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS,UUID";

    #Man home config in nvim
    hmc = "nvim \"+Man home-configuration.nix | only\"";
  };
}
