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
#if project id not null
if [[ -n "$prj_id" ]]; then
  #if main_query not null, add project id
  if [[ -n "$main_query" ]]; then
    main_query="$main_query AND log:\"project $prj_id\""
  else
    main_query="log:\"project $prj_id\""
  fi
fi
read -p "
1. campaign
2. template (use this option for proofs)
3. journey
4. list
5. custom event
6. user update
7. other
Include the above id's? Enter corresponding number or press enter to skip: " id_type
#if type of id not null
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
    #if id not null
    if [[ -n "$id" ]]; then
      subquery="log:\"$id\""
    fi
    #check if they want to check validate, publish, or update enabled calls
    read -p "
1. Validate? (save draft)
2. Publish?
3. Turn on?
Enter corresponding number or press enter to skip: " id_wkflw
    #if id not null
    if [[ -n "$id_wkflw" ]]; then
      #if validate workflow
      if [[ $id_wkflw == 1 ]]; then
        subquery2="log:\"workflows/validateWorkflow\""
      #if publish workflow
      elif [[ $id_wkflw == 2 ]]; then
        subquery2="log:\"workflows/publish\""
      elif [[ $id_wkflw == 3 ]]; then
        subquery2="log:\"workflows/updateEnabled\""
      fi
      if [[ -n $subquery ]]; then
        subquery="$subquery AND $subquery2"
      else
        subquery="$subquery2"
      fi
    fi
  #if list
  elif [[ $id_type == 4 ]]; then
    read -p "Enter list id: " id
    subquery="log:\"$id\""
  #if custom event
  elif [[ $id_type == 5 ]]; then
    read -p "Enter custom event name or enter to skip: " id
    #check if custom event name entered
    if [[ -n "$id" ]]; then
      subquery="log:\"$id\" AND (log:\"events/track\" OR log:\"events/trackBulk\")"
    else
      subquery="(log:\"events/track\" OR log:\"events/trackBulk\")"
    fi
  #if users/update call
  elif [[ $id_type == 6 ]]; then
    subquery="(log:\"users/update\" OR log:\"users/bulkUpdate\")"
  fi
  elif [[ $id_type == 7 ]]; then
    read -p "Enter other query: " id
    subquery="log:\"$id""
  fi
fi
#check if subquery not null and create main query
if [[ -n $subquery ]]; then
  if [[ -n $main_query ]]; then
    main_query="$main_query AND $subquery"
  else
    main_query="$subquery"
  fi
fi
#output query and navigate to kube
echo "$main_query

Redirecting you to kube..."
#open kube search, must use this format or else # gets url encoded to %23
open -n -a "Google Chrome" --args "https://logs.mon-itbl.co/app/discover#/?_g=(filters:!(),refreshInterval:(pause:!t,value:0),time:(from:now-15m,to:now))&_a=(columns:!(),filters:!(),index:'67eede50-8066-11ec-a886-f5ecefe9e33e',interval:auto,query:(language:kuery,query:'$main_query'),sort:!(!('@timestamp',desc)))"
