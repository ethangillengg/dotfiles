#!/usr/bin/env -S nix shell nixpkgs#curl nixpkgs#jq --command bash

function fetch_image() {
  name=$(echo $1 | cut -d '|' -f 1)
  ext=$(echo $1 | cut -d '|' -f 2 | cut -d '/' -f 2)
  id=$(echo $1 | cut -d '|' -f 3)

  jq -n \
      --arg name $name\
      --arg ext $ext\
      --arg id $id\
      --arg sha256 "$(nix-prefetch-url https://i.imgur.com/$id.$ext)" \
      '{"name": $name, "ext": $ext, "id": $id, "sha256": $sha256}'
}

album="qlNokTk" # https://imgur.com/a/bXDPRpV
clientid="0c2b2b57cdbe5d8"

result=$(curl https://api.imgur.com/3/album/$album -H "Authorization: Client-ID $clientid")
images=$(echo $result | jq -r '.data.images[] | "\(.description)|\(.type)|\(.id)"')


list=$(
while read -r image; do
    fetch_image $image
done <<< "$images"
wait
)

echo $list | jq -r -s
