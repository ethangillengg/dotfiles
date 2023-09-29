#!/usr/bin/env bash
selected=$(git -c color.status=always -c status.relativePaths=true status -su | fzf --height 80% --preview 'git diff HEAD --color=always {2} | delta' --ansi -m -0)
git add $(printf "$selected" | nawk 'NF=2{print $2}')

printf "\n\033[1mNew Git Status:\033[0m\n"
git status --short

