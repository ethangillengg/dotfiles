{pkgs, ...}: {
  users.users.ethan = {
    isNormalUser = true;
    description = "ethan";
    extraGroups = ["wheel" "network" "docker" "video" "cdrom"];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];
}
