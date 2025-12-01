{
  config,
  pkgs,
  libs,
  ...
}: {
  imports = [
    ./direnv.nix
    ./vscode.nix
    ./nvim.nix
    ./dotnet-sdk.nix
  ];
}
