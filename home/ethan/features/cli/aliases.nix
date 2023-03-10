{
  # simple aliases that are compatible across all shells
  home.shellAliases = {
    ll = "lsd -l";
    lt = "lsd -l --tree --depth=4";
    la = "lsd -lA";

    v = "nvim";
    vi = "nvim";
    vim = "nvim";

    ga = "git add .";
    lg = "gitui";

    hm = "home-manager switch --flake /home/ethan/.dotfiles#ethan@nixtop";
    nr = "sudo nixos-rebuild switch --flake /home/ethan/.dotfiles#nixtop";

    #manga reader
    mr = "feh -FZ --cache-size 2048 --on-last-slide hold --font \"yudit/40\" --scroll-step 50 --info \"echo %u/%l\" $argv; ";
  };
}
