{pkgs, ...}: let
  ghFormatIssue = pkgs.writeShellScriptBin "gh-format-issue" ''
    #!/usr/bin/env bash
    PR_NAME=$(gh issue view $1 --json title --jq '.title')
    echo "$PR_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/$/-eg/'
    # wl-copy "$PR_NAME_DASHED"
  '';
  # PR_NAME_DASHED=$(echo "$PR_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/$/-eg/')
  # wl-copy "$PR_NAME_DASHED"
in {
  programs = {
    gh = {
      enable = true;
      settings = {
        editor = "nvim";
        git_protocol = "ssh";

        aliases = {
          pv = "pr view";
          d = "dash";
        };
      };
      extensions = with pkgs; [
        gh-eco
      ];
    };
    gh-dash = {
      enable = true;
      settings = {
        keybindings = {
          issues = [
            {
              key = "C";
              command = ''
                PR_NAME=$(gh issue view {{.IssueNumber}} --json title --jq '.title')
                PR_NAME_DASHED=$(echo "$PR_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | sed 's/$/-eg/')
                # cat into temp file and edit in nvim
                echo "$PR_NAME_DASHED" > /tmp/gh-issue-name
                nvim /tmp/gh-issue-name
                cd {{.RepoPath}} && git checkout -b "$(cat /tmp/gh-issue-name)"
              '';
              description = "Create Issue Branch";
            }
            {
              key = "enter";
              command = "gh issue view {{.IssueNumber}} --repo \"{{.RepoName}}\" | glow -p";
              description = "View Issue";
            }
          ];
          prs = [
            {
              key = "C";
              command = ''
                cd {{.RepoPath}} &&
                gh pr checkout {{.PrNumber}} &&
                nvim -c ":DiffviewOpen main...{{.HeadRefName}}"
              '';
              description = "PR Diff in Neovim";
            }
            {
              key = "enter";
              command = "gh pr view {{.PrNumber}} --repo \"{{.RepoName}}\"";
              description = "View PR";
            }
          ];
        };

        repoPaths = {
          default_path = "~/Code";
          "AhadAli01/HeartLens" = "~/Code/School/Heartlens";
        };
      };
    };
  };
}
