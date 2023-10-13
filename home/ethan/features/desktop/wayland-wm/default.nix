{pkgs, ...}: {
  imports = [
    ./hyprland

    ./waybar.nix
    ./mako.nix
    ./swaylock.nix
    ./zathura.nix
    ./qutebrowser.nix
  ];

  home.packages = with pkgs; [
    # grim
    imv
    slurp
    waypipe
    wf-recorder
    wl-clipboard
    xdg-desktop-portal-hyprland
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
