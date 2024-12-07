{
  config,
  pkgs,
  libs,
  ...
}: {
  imports = [
    ./direnv.nix
    ./vscode.nix
  ];
}
