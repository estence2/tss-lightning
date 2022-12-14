#!/usr/bin/env zsh

#input workflow node id and set number of users in tile
read -p "Enter tile id: " tileId
read -p "Enter limit of visitors: " limit

#print URL
echo "Redirecting you to...

https://boss.prd-itbl.co/workflows/visitorsAtNode?workflowNodeId=$tileId&csv=true&limit=$limit
"

#open link in boss to get csv info
open -n -a "Google Chrome" --args "https://boss.prd-itbl.co/workflows/visitorsAtNode?workflowNodeId=$tileId&csv=true&limit=$limit
"

#Get input from website, must type "~" to go to next prompt
read -d "~" -p $'Paste visitors in node (type \"~\" when done):\n' visitors

#remove "Some(" and ")"
echo "$visitors" | sed -e 's/Some(//g' -e 's/)//g' >> visitors_in_node_$tileId.csv
echo "

New file created: visitors_in_node_$tileId.csv"

#open csv as text
open -e visitors_in_node_$tileId.csv
