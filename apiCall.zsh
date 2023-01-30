#!/usr/bin/env zsh
#get api key
api_key=$(head -1 ~/bin/api.key)

#id's from your project
#replace on line 101
campaignId=4752262
#replace on line 105
listId=1988320
#replace on line 156
journeyId=327907

#Email based or UUID based
#echo "
#1. Email
#2. UUID"
#read -p "Email or UUID based project? If empty, default is email: " id
#check if id not null
#if [[ -z "$id" ]]; then
#   id=1
#fi

#get type of call
echo "
1. Update user
2. Track custom event
3. Trigger Campaign
4. Trigger Journey"
read -p "Enter number of call you would like to make: " call
echo ""

endpoint=""
fieldName="fieldName"
#fieldValue="fieldValue"
#start dataFields object
subquery="{"

#users update call
if [[ $call == 1 ]]; then
    read -p "Enter user email: " email
    echo ""
    endpoint="https://api.iterable.com/api/users/update"
    #prompt for dataFields until left blank
    until [[ -z $fieldName ]]
    do
        read -p "Enter field name (leave blank when done): " fieldName
            if [[ -z $fieldName ]]; then
                break
            fi
        read -p "Enter field value (leave blank when done): " fieldValue
        subquery+="\"${fieldName}\":${fieldValue},"
    done
    #remove trailing comma
    subquery=$(echo "$subquery" | sed 's/.$//')
    #close dataFields objects
    subquery+="}"
    #make API Call
    #only include dataFields if not null
    if [[ -z $fieldValue ]]; then
        #dataFields null
        curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'"}'
    else
        #dataFields not null 
        curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","dataFields":'${subquery}'}'
    fi
#events/track call
elif [[ $call == 2 ]]; then
    read -p "Enter user email: " email
    echo ""
    endpoint="https://api.iterable.com/api/events/track"
    read -p "Enter name of event: " eventName
    #prompt for dataFields until left blank
    until [[ -z $fieldName ]]
    do
        read -p "Enter field name (leave blank when done): " fieldName
            if [[ -z $fieldName ]]; then
                break
            fi
        read -p "Enter field value (leave blank when done): " fieldValue
        subquery+="\"${fieldName}\":${fieldValue},"
    done
    #remove trailing comma
    subquery=$(echo "$subquery" | sed 's/.$//')
    #close dataFields objects
    subquery+="}"
    #make API Call
    #only include dataFields if not null
    if [[ -z $fieldValue ]]; then
        #dataFields null
        curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","eventName":"'${eventName}'"}'
    else
        #dataFields not null 
        curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","eventName":"'${eventName}'","dataFields":'${subquery}'}'
    fi
#trigger campaign
elif [[ $call == 3 ]]; then
    endpoint="https://api.iterable.com/api/campaigns/trigger"
    #set campaign id
    read -p "Enter campaign id. If empty, default is '${campaignId}': " campaignId
    #if campaignId blank, set default value
    campaignId=${campaignId:-4752262}
    #set send list id
    read -p "Enter list id. If empty, default is '${listId}': " listId
    #if listId blank, set default value
    listId=${listId:-1988320}
    #add brackets to make list
    listId=[${listId}]
    #set suppression list id
    read -p "Enter suppression list id. If empty, default is none: " listId_suppression
    #prompt for dataFields until left blank
    until [[ -z $fieldName ]]
    do
        read -p "Enter field name (leave blank when done): " fieldName
            if [[ -z $fieldName ]]; then
                break
            fi
        read -p "Enter field value (leave blank when done): " fieldValue
        subquery+="\"${fieldName}\":${fieldValue},"
    done
    #remove trailing comma
    subquery=$(echo "$subquery" | sed 's/.$//')
    #close dataFields objects
    subquery+="}"
    #make API Call
    #only include dataFields if not null
    if [[ -z $fieldValue ]]; then
        #dataFields null
        #only include suppression list if not null
        if [[ -z $listId_suppression ]]; then
            #suppression list null
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"campaignId":'${campaignId}',"listIds":'${listId}'}'
        else
            #suppression list not null
            listId_suppression="["$listId_suppression"]"
            echo "${listId_suppression}"
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"campaignId":'${campaignId}',"listIds":'${listId}',"suppressionListIds":'${listId_suppression}'}'
        fi
    else
        #dataFields exist
        #only include suppression list if not null
        if [[ -z $listId_suppression ]]; then
            #suppression list null
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"campaignId":'${campaignId}',"listIds":'${listId}',"dataFields":'${subquery}'}'
        else
            #suppression list not null
            listId_suppression="["$listId_suppression"]"
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"campaignId":'${campaignId}',"listIds":'${listId}',"suppressionListIds":'${listId_suppression}',"dataFields":'${subquery}'}'
        fi
    fi
#trigger workflow
elif [[ $call == 4 ]]; then
    read -p "Enter user email: " email
    echo ""
    endpoint="https://api.iterable.com/api/workflows/triggerWorkflow"
    read -p "Enter journey id. If empty, default is '${journeyId}': "
    journeyId=${journeyId:-327907}
    echo ""
    #prompt for dataFields until left blank
    until [[ -z $fieldName ]]
    do
        read -p "Enter field name (leave blank when done): " fieldName
            if [[ -z $fieldName ]]; then
                break
            fi
        read -p "Enter field value (leave blank when done): " fieldValue
        subquery+="\"${fieldName}\":${fieldValue},"
    done
    #remove trailing comma
    subquery=$(echo "$subquery" | sed 's/.$//')
    #close dataFields objects
    subquery+="}"
    #make API Call
    #only include dataFields if not null
    if [[ -z $fieldValue ]]; then
        #dataFields null
        curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","workflowId":'${journeyId}'}'
    else
        #dataFields not null
        curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","workflowId":'${journeyId}',"dataFields":'${subquery}'}'
    fi
fi