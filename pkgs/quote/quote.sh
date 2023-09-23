#!/usr/bin/env bash

curl -s https://api.quotable.io/random?maxLength=50 | jq -r '{content, author} | "\"\(.content)\"\n\n- \(.author)"'
