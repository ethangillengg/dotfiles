#!/usr/bin/env bash

# 1. Search for text in files using Ripgrep
# 2. Interactively restart Ripgrep with reload action
# 3. Open the file in zathura
RG_PREFIX="rga --column --no-heading --color=always --smart-case"
INITIAL_QUERY="${*:-}"
: | fzf --ansi --sort --disabled --query "$INITIAL_QUERY" \
    --prompt="Query > "  \
    --bind "start:reload:$RG_PREFIX {q} *.pdf" \
    --bind "change:reload:sleep 0.08; $RG_PREFIX {q} *.pdf || true" \
    --delimiter : \
    --preview='
      printf "\033[36m\033[1m%s - %s\033[0m\n\n" {1} {3} &&
      pdftotext {1} -l $(echo {3} | sed "s/Page\s//g") -f $(echo {3} | sed "s/Page\s//g") - |
      rg --pretty {q} --passthru --no-line-number --smart-case
    ' \
    --bind 'enter:execute-silent(zathura {1} --page=$(echo {3} | sed "s/Page\s//g")&)' \

