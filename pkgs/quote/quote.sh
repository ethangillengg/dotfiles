#!/usr/bin/env bash


quote=$(curl -s https://api.quotable.io/random?maxLength=50)

if [ -z "$quote" ]; then
  printf "\"404 quote not found\"\n- Me\n"
else
  echo $quote | jq -r '{content, author} | "\"\(.content)\"\n- \(.author)"'
fi


