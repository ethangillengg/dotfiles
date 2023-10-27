{pkgs, ...}: let
  pass = "${pkgs.pass}/bin/pass";
in {
  home.shellAliases = {
    gpt = "OPENAI_API_KEY=$(${pass} show personal/openai) chatgpt";
  };

  home.packages = [
    pkgs.chatgpt-cli
  ];
}
