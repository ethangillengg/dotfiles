# https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/neovim/utils.nix#L27
{pkgs, ...}: let
  config = pkgs.neovimUtils.makeNeovimConfig {
    extraLuaPackages = p: [p.luarocks p.magick];
    withNodeJs = false;
    withRuby = false;
    withPython3 = false;
    # https://github.com/NixOS/nixpkgs/issues/211998
    customRC = "luafile ~/.config/nvim/init.lua";
  };
in {
  nixpkgs.overlays = [
    (_: super: {
      neovim-custom =
        pkgs.wrapNeovimUnstable
        (super.neovim-unwrapped.overrideAttrs (oldAttrs: {
          version = "master";
          buildInputs = oldAttrs.buildInputs ++ [super.tree-sitter];
        }))
        config;
    })
  ];
  environment.systemPackages = with pkgs; [
    neovim-custom

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
    bun
    asmfmt
    # GO
    gopls
    go
    templ
    tailwindcss
    tailwindcss-language-server

    deno
    nodePackages_latest.volar
    nodePackages_latest.typescript-language-server
    xmlformat
    lemminx
    biome
    csharp-ls

    omnisharp-roslyn
    dotnet-sdk_8
    dotnet-runtime_8
    dotnet-aspnetcore_8
    csharpier
  ];
}
