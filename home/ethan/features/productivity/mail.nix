{
  pkgs,
  lib,
  config,
  ...
}: let
  common = rec {
    realName = "Ethan Gill";
  };
  gmail =
    rec {
      imap = {
        host = "imap.gmail.com";
        port = 993;
      };

      smtp = {
        host = "smtp.gmail.com";
        port = 465;
      };
      himalaya.enable = true;
      aerc.enable = true;
      thunderbird.enable = true;
    }
    // common;
in {
  programs.himalaya.enable = true;
  programs.aerc.enable = true;

  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      Uni = rec {
        address = "ethan.gill@ucalgary.ca";
        userName = address;
        realName = "Ethan Gill";
        primary = true;
        thunderbird = {
          enable = true;
          perIdentitySettings = id: {
            "mail.identity.id_${id}.protectSubject" = false;
          };
        };

        imap = {
          host = "outlook.office365.com";
          port = 993;
        };

        smtp = {
          host = "smtp.office365.com";
          tls.useStartTls = true;

          port = 587;
        };
      };

      G =
        rec {
          address = "greatredswarmjp@gmail.com";
          userName = address;
          passwordCommand = "pass show email/google";
        }
        // gmail;

      G-B =
        rec {
          address = "gill.ethan123@gmail.com";
          userName = address;
          passwordCommand = "pass show email/google-business";
        }
        // gmail;

      G-2 =
        rec {
          address = "greatredswarm@gmail.com";
          userName = address;
          passwordCommand = "pass show email/google-secondary";
        }
        // gmail;
    };
  };
}
