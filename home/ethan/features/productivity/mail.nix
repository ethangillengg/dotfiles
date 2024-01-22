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

          settings = id: {
            # Folders
            "mail.identity.id_${id}.draft_folder" = "imap://ethan.gill%40ucalgary.ca@outlook.office365.com/Drafts";
            "mail.identity.id_${id}.fcc_folder" = "imap://ethan.gill%40ucalgary.ca@outlook.office365.com/Sent%20Items";
            "mail.identity.id_${id}.stationery_folder" = "imap://ethan.gill%40ucalgary.ca@outlook.office365.com/Templates";
            "mail.identity.id_${id}.archive_folder" = "imap://ethan.gill%40ucalgary.ca@outlook.office365.com/Archive";
            "mail.identity.id_${id}.junk_folder" = "imap://ethan.gill%40ucalgary.ca@outlook.office365.com/Junk%20Email";
            "mail.server.server_${id}.trash_folder_name" = "Deleted%20Items";
            "mail.server.server_${id}.spamActionTargetFolder" = "imap://ethan.gill%40ucalgary.ca@outlook.office365.com/Junk%20Email";

            ## Authentication needs the OAuth params:
            # IMAP
            "mail.server.server_${id}.authMethod" = 10; # OAuth2
            "mail.server.server_${id}.oauth2.issuer" = "login.microsoftonline.com";
            "mail.server.server_${id}.oauth2.scope" = "https://outlook.office.com/IMAP.AccessAsUser.All https://outlook.office.com/POP.AccessAsUser.All https://outlook.office.com/SMTP.Send offline_access";
            # SMTP
            "mail.smtpserver.smtp_${id}.authMethod" = 10; # OAuth2
            "mail.smtpserver.smtp_${id}.oauth2.issuer" = "login.microsoftonline.com";
            "mail.smtpserver.smtp_${id}.oauth2.scope" = "https://outlook.office.com/IMAP.AccessAsUser.All https://outlook.office.com/POP.AccessAsUser.All https://outlook.office.com/SMTP.Send offline_access";
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
