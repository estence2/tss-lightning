#!/usr/bin/env zsh
api_key=$(head -1 ~/bin/apiCall.config)

#id's from your project
#replace on line 101
email_campaignId=4752262
#replace on line 105
email_listId=1988320
#replace on line 156
email_journeyId=327907
#replace on line
uuid_campaignId=7016862
#replace on line
uuid_listId=2382473
#replace on line
uuid_journeyId=347945

#Email based or UUID based
echo "
1. Email
2. UUID"
read -p "Email or UUID based project? If empty, default is email: " id
#check if id is 2
if [[ $id == 2 ]]; then
    api_key=$(head -1 ~/bin/apiCall_userId.config)
fi

#get type of call
echo "
1. Update user
2. Track custom event
3. Trigger Campaign
4. Trigger Journey"
read -p "Enter number of call you would like to make: " call
echo ""
#set unique id
#don't need this info for campaigns/trigger
if [[ $call != 3 ]]; then
    if [[ $id == 2 ]]; then
        read -p "Enter user id: " uuid
    else
        read -p "Enter user email: " email
    fi
fi

endpoint=""
fieldName="fieldName"
#fieldValue="fieldValue"
#start dataFields object
subquery="{"

#users update call
if [[ $call == 1 ]]; then
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
        #if uuid based
        if [[ $id == 2 ]]; then
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"userId":"'${uuid}'"}'
        else
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'"}'
        fi
    else
        #dataFields not null 
        #if uuid
        if [[ $id == 2 ]]; then
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"userId":"'${uuid}'","dataFields":'${subquery}'}'
        else
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","dataFields":'${subquery}'}'
        fi
    fi
#events/track call
elif [[ $call == 2 ]]; then
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
        #if uuid based
        if [[ $id == 2 ]]; then
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"userId":"'${uuid}'","eventName":"'${eventName}'"}'
        else
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","eventName":"'${eventName}'"}'
        fi
    else
        #dataFields not null 
        #if uuid
        if [[ $id == 2 ]]; then
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"userId":"'${uuid}'","eventName":"'${eventName}'","dataFields":'${subquery}'}'
        else
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","eventName":"'${eventName}'","dataFields":'${subquery}'}'
        fi
    fi
#trigger campaign
elif [[ $call == 3 ]]; then
    endpoint="https://api.iterable.com/api/campaigns/trigger"
    #set campaign id
    #uuid project
    if [[ $id == 2 ]]; then
        read -p "Enter campaign id. If empty, default is '${uuid_campaignId}': " campaignId
        #if campaignId blank, set default value
        campaignId=${campaignId:-7016862}
        #set send list id
        read -p "Enter list id. If empty, default is '${uuid_listId}': " listId
        #if listId blank, set default value
        listId=${listId:-2382473}
    else
        read -p "Enter campaign id. If empty, default is '${email_campaignId}': " campaignId
        #if campaignId blank, set default value
        campaignId=${campaignId:-4752262}
        #set send list id
        read -p "Enter list id. If empty, default is '${email_listId}': " listId
        #if listId blank, set default value
        listId=${listId:-1988320}
    fi
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
    endpoint="https://api.iterable.com/api/workflows/triggerWorkflow"
    if [[ $id == 2 ]]; then
        read -p "Enter journey id. If empty, default is '${uuid_journeyId}': " journeyId
        journeyId=${journeyId:-347945}
    else
        read -p "Enter journey id. If empty, default is '${email_journeyId}': " journeyId
        journeyId=${journeyId:-327907}
    fi    
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
        #if uuid based
        if [[ $id == 2 ]]; then
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"userId":"'${uuid}'","workflowId":'${journeyId}'}'
        else
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","workflowId":'${journeyId}'}'
        fi
    else
        #dataFields not null 
        #if uuid
        if [[ $id == 2 ]]; then
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"userId":"'${uuid}'","workflowId":'${journeyId}',"dataFields":'${subquery}'}'
        else
            curl -XPOST "${endpoint}" -H "Api-Key: ${api_key}" -d '{"email":"'${email}'","workflowId":'${journeyId}',"dataFields":'${subquery}'}'
        fi
    fi
fi
