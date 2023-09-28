# This file (and the global directory) holds config that i use on all hosts
{
  pkgs,
  lib,
  outputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    neovim

    # Nix
    nil
    alejandra
    # Lua
    lua-language-server
    stylua
    # C/C++
    clang-tools # For 'clangd'
    # Misc.
    vscode-langservers-extracted
    prettierd
  ];
}
