{pkgs, ...}: {
  environment.systemPackages = with pkgs; [direnv nix-direnv];
  # nix options for derivations to persist garbage collection
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
}
