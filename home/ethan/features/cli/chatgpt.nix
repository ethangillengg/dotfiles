{pkgs, ...}: let
  pass = "${pkgs.pass}/bin/pass";

  formats = with pkgs.formats; {
    yaml = yaml {};
  };
in {
  home.shellAliases = {
    ai = "OPENAI_API_KEY=$(${pass} show personal/openai) aichat";
  };

  xdg.configFile = {
    "aichat/config.yaml".source = formats.yaml.generate "aichat-config" {
      keybindings = "vi";
      model = "openai:gpt-4-turbo-preview";
      wrap = 120;
    };

    "aichat/roles.yaml".source = formats.yaml.generate "aichat-roles" [
      {
        name = "shell";
        temperature = 0.7;
        prompt = "Act as a linux shell expert. Answer only with code, do not write explanations.";
      }
      {
        name = "nix";
        prompt = "Act as an expert in Nix, NixOS, home-manager, and Neovim. Solve problems, and provide examples in a clear and helpful manner.";
      }
    ];
  };

  home.packages = with pkgs; [
    aichat
    mods
  ];
}
