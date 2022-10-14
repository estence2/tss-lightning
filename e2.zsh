#!/usr/bin/env zsh
#get email to hash
read -p "Enter email or press enter to skip: " email
#hash email
email_hash=$(echo -n "$email" | shasum -a 256 | awk '{print $1}')
#create main query, check if email not null
if [[ -n "$email" ]]; then
  main_query="message.recipient : $email_hash"
fi

echo "$main_query"
