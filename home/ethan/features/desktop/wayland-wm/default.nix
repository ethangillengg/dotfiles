{pkgs, ...}: {
  imports = [
    ./hyprland
    ./sway

    ./eww

    ./waybar.nix
    ./mako.nix
    ./swaylock.nix
    ./zathura.nix
    ./qutebrowser.nix
    ./tofi.nix
  ];

  home.packages = with pkgs; [
    imv
    slurp
    waypipe
    wf-recorder
    wl-clipboard
    xdg-desktop-portal-hyprland
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    LIBSEAT_BACKEND = "logind";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };
}
