#!/usr/bin/env zsh
#must have must have installed jq. see - https://docs.google.com/document/d/17l1MqJVxqAPsgAaf_-0wfgQTP6JA9jyJp61Ga0pfvaM/edit#heading=h.bd53n49kslf
####Step 1: install homebrew
####Step 2: brew install jq

read -d "~" -p $'Paste json (type \"~\" when done):\n' json

echo "$json" > tmp
echo "

~~~~~~~JSON OUTPUT:~~~~~~~~
"

jq '.' < tmp