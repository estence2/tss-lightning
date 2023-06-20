#!/usr/bin/env zsh
#email or uuid based?
echo "1. email-based project
2. uuid-based project"
read -p "Email or User ID based project? Enter corresponding number: " projType

#if email based
if [[ $projType == 1 ]]; then
  #get email to hash
  read -p "Enter email or press enter to skip: " email
  #hash email
  email_hash=$(echo -n "$email" | shasum -a 256 | awk '{print $1}')
  #create main query, check if email not null
  if [[ -n "$email" ]]; then
    main_query="message.recipient : $email_hash"
  fi
#if uuid based
elif [[ $projType == 2 ]]; then
  #get itbl user id
  read -p "Enter itblUserId or press enter to skip: " uuid
  if [[ -n "$uuid" ]]; then
    main_query="message.recipient : $uuid"
  fi
fi
#get id number
echo "
1. campaign
2. template (use this option for proofs)
3. journey
4. project
5. other"
read -p "Include the above id's? Enter corresponding number or press enter to skip: " id_type
echo ""
#check if id_type not null
if [[ -n "$id_type" ]]; then
#check id type and get the id
  if [[ $id_type == 1 ]]; then
    read -p "Enter campaign id: " id
    subquery="campaign.id : $id"
  elif [[ $id_type == 2 ]]; then
    read -p "Enter template id: " id
    subquery="template.id : $id"
  elif [[ $id_type == 3 ]]; then
    read -p "Enter workflow id: " id
    subquery="workflow.id : $id"
  elif [[ $id_type == 4 ]]; then
    read -p "Enter project id: " id
    subquery="project.id : $id"
  elif [[ $id_type == 5 ]]; then
    read -p "Enter other query: " id
    subquery="$id"
  fi
fi
#create final query
#check if main_query not null
if [[ -n "$main_query" ]]; then
  #check if subquery not null
  if [[ -n "$subquery" ]]; then
    main_query="$main_query AND $subquery"
  fi
#if main_query is null but subquery is
else
  main_query="$subquery"
fi
#open e2 page with query
echo "
$main_query

Redirecting you to events stream..."
#open e2 search, must use this format or else # gets url encoded to %23
open -n -a "Google Chrome" --args "https://logs.mon-itbl.co/app/discover#/?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(columns:!(),filters:!(),index:'767d3500-5645-11e9-b1e6-07895cd9f6f5',interval:auto,query:(language:kuery,query:'$main_query'),sort:!(!('@timestamp',desc)))"
