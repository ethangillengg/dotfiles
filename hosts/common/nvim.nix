# This file (and the global directory) holds config that i use on all hosts
{pkgs, ...}: {
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
    nodePackages_latest.bash-language-server
    shfmt
    marksman
    yamlfmt
    # for copilot (https://github.com/zbirenbaum/copilot.lua)
    nodejs_18
    asmfmt
    gopls
    go
    deno
  ];
}
