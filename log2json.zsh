#!/usr/bin/env zsh
#requires jq to be installed

#get k8s log file
read -d "~" -p $'Paste k8s log file (type \"~\" when done):\n' log

#remove backslashes
tmp=$(echo "$log" | sed -e 's/{/{\n/g' -e 's/\\//g' -e 's/}/}\n/g')
#remove 2nd to last line & last line from file - k8s kerfuffle
tmp=$(echo "$tmp" | sed -e '2d' -e '$d')

#create tmp file
echo "$tmp" > tmp
echo "

~~~~~~~JSON OUTPUT:~~~~~~~~
"

#output prettier json
jq '.' < tmp