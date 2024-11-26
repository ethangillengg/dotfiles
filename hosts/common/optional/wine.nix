{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # lutris
    (lutris.override {
      extraLibraries = pkgs: [
        # List library dependencies here
        vulkan-tools
        vulkan-loader
        amdvlk
      ];
    })

    # support both 32- and 64-bit applications
    wineWowPackages.stable

    # support 32-bit only
    wine

    # support 64-bit only
    # (wine.override {wineBuild = "wine64";})

    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull

    cdemu-client
    cdemu-daemon

    wine-staging
    vulkan-tools
    vulkan-loader
    amdvlk
    # libvulkan
    # libvulkan_i686
    # vulkan-loader.i686
  ];
  programs.cdemu.enable = true;

  nixpkgs.config.multilib.enable = true;
}
