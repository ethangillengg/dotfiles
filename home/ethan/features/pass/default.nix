{
  pkgs,
  config,
  ...
}: {
  programs.password-store = {
    enable = true;
    settings = {PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";};
    package = pkgs.pass.withExtensions (p: [p.pass-otp]);
  };

  # firefox extension
  programs.browserpass.enable = true;

  # auto sync passwords using git
  services.git-sync = {
    enable = true;
    repositories = {
      passwords = {
        path = "${config.home.homeDirectory}/.password-store";
        uri = "git@github.com:ethangillengg/passwords.git";
      };
    };
  };
}
