{
  pkgs,
  config,
  ...
}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      # See nixpkgs' firefox/wrapper.nix to check which options you can use
      cfg = {
        # Gnome shell native connector
        enableGnomeExtensions = true;
      };
    };

    profiles. "${config.home.username}" = {
      isDefault = true;

      extensions.packages = with pkgs.inputs.firefox-addons; [
        # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        # privacy-badger
        tridactyl
        i-dont-care-about-cookies
        darkreader
        ublock-origin
        sponsorblock
        browserpass
      ];

      settings = {
        "browser.disableResetPrompt" = true;
        # "browser.download.panel.shown" = true;
        # "browser.download.useDownloadDir" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "https://start.duckduckgo.com";
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","library-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["import-button","personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","_testpilot-containers-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":18,"newElementCount":4}'';
        # "dom.security.https_only_mode" = true;
        # "identity.fxaccounts.enabled" = false;
        # "privacy.trackingprotection.enabled" = true;
        # "signon.rememberSignons" = false;
      };
    };
  };
}
