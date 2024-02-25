{pkgs, ...}: {
  imports = [
    ./hyprland
    ./sway
    ./swaylock.nix
    ./swayidle.nix

    ./waybar.nix
    ./mako.nix
    ./tofi.nix
  ];

  home.packages = with pkgs; [
    imv
    slurp
    waypipe
    wf-recorder
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-wlr
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    LIBSEAT_BACKEND = "logind";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XDG_CACHE_HOME = "$HOME/.cache";
  };
}
