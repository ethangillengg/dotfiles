{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  xdg.desktopEntries = {
    # override  for "--disable-gpu" in wayland
    obsidian = {
      name = "Obsidian";
      genericName = "obisidan";
      exec = "obsidian --disable-gpu";
      terminal = false;
      categories = ["Application"];
    };
  };
}
