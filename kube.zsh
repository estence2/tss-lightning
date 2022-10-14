#!/usr/bin/env zsh
#get email
read -p "Enter email or press enter to skip: " email
#create main query, check if email not null
if [[ -n "$email" ]]; then
  main_query="log:\"$email\""
fi
#get project id
read -p "
Enter project ID or press enter to skip: " prj_id
#if main_query not null, add project id
if [[ -n "$main_query" ]]; then
  main_query="$main_query AND log:\"project $prj_id\""
else
  main_query="log:\"project $prj_id\""
fi
read -p "
1. campaign
2. template
3. journey
4. list
5. custom event
6. user update
Include the above id's? Enter corresponding number or press enter to skip: " id_type
#if id not null
if [[ -n "$id_type" ]]; then
#check id type and get the id
  #if campaign
  if [[ $id_type == 1 ]]; then
    read -p "Enter campaign id: " id
    subquery="log:\"campaignId $id\""
  #if template
  elif [[ $id_type == 2 ]]; then
    read -p "Enter template id: " id
    subquery="log:\"templateId $id\""
  #if workflow
  elif [[ $id_type == 3 ]]; then
    read -p "Enter workflow id: " id
    subquery="log:\"$id\""
  #if list
  elif [[ $id_type == 4 ]]; then
    read -p "Enter list id: " id
    subquery="log:\"listId $id\""
  #if custom event
  elif [[ $id_type == 5 ]]; then
    read -p "Enter custom event name or enter to skip: " id
    #check if custom event name entered
    if [[ -n "$id" ]]; then
      subquery="log:\"$id\" AND (log:\"events/track\" OR log:\"events/bulkTrack\")"
    else
      subquery="(log:\"events/track\" OR log:\"events/bulkTrack\")"
    fi
  #if users/update call
  elif [[ $id_type == 6 ]]; then
    subquery="(log:\"users/update\" OR log:\"users/updateBulk\")"
  fi
fi
