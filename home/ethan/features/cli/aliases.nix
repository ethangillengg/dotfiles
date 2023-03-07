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
  };
}
