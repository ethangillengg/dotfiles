{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    tree-sitter

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
    nodePackages_latest.nodejs
    bun
    # GO
    gopls
    go
    templ
    tailwindcss
    tailwindcss-language-server

    vue-language-server
    nodePackages_latest.typescript-language-server
    xmlformat
    lemminx
    biome

    roslyn-ls
    dotnet-sdk_9
    dotnet-runtime_9
    dotnet-aspnetcore_9
    netcoredbg
    csharpier
    rzls
  ];
}
