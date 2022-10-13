#!/usr/bin/env zsh

#input blobby namespace
read -p "Enter blobby namespace: " namespace
#input blobby ID
read -p "Enter blobby ID: " bId
#create blobby url
url="https://blobby.internal.prd-itbl.co/$namespace/$bId"
#output url
echo "
Redirecting you to...

$url"
#open blobby url
open "$url"
