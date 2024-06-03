{
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
    };
    gh-dash = {
      enable = true;
      settings = {
        prSections = [
          {
            title = "My Pull Requests";
            filters = "is:open author:@me";
          }
          {
            title = "Needs Review";
            filters = "is:open review-requested:@me";
          }
          {
            title = "Manifast";
            filters = "repo:SunwaptaSolutions/MW5-Compliance is:open";
          }
          {
            title = "PSM";
            filters = "repo:Calgary-Co-op/production-shrink-management-app is:open";
          }
        ];
        issuesSections = [
          {
            title = "Assigned";
            filters = "is:open assignee:@me";
          }
          {
            title = "Manifast";
            filters = "repo:SunwaptaSolutions/MW5-Compliance is:open -linked:pr";
          }
          {
            title = "PSM";
            filters = "repo:Calgary-Co-op/production-shrink-management-app is:open -linked:pr";
          }
        ];

        keybindings = {
          issues = [
            {
              key = "C";
              command = ''
                PR_NAME=$(gh issue view {{.IssueNumber}} --repo {{.RepoName}} --json title --jq '.title')
                PR_NAME_DASHED=$(echo "{{.IssueNumber}} $PR_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
                # cat into temp file and edit in nvim
                echo "$PR_NAME_DASHED" > /tmp/gh-issue-name
                nvim /tmp/gh-issue-name
                cd {{.RepoPath}}
                # branch off of latest main
                git switch main && git pull && git checkout -b "$(cat /tmp/gh-issue-name)"
                kill -9 $PPID
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
                cd {{.RepoPath}}
                gh pr checkout {{.PrNumber}}
                kill -9 $PPID
              '';
              description = "Review PR in nvim";
            }
            {
              key = "enter";
              command = "gh pr view {{.PrNumber}} --comments --repo \"{{.RepoName}}\"";
              description = "View PR";
            }
          ];
        };

        repoPaths = {
          default_path = "~/Local";
        };
      };
    };
  };
}
