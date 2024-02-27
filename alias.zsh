#Alias file to share with team
###############################
#define email and project info
email="ellen.stence@iterable.com"

project_info="
Cluster ID: 24
Project ID: 14523
Organization ID: 1344
"
###############################

#Functions I like to use
#history
h () {history}

#source
src () {source ~/.zshrc}

#edit zshrc
v () {vim ~/.zshrc}

#edit alias.zsh
v_alias () {vim ~/.oh-my-zsh/custom/alias.zsh}

#Make directory -> Go inside directory
mcd () {mkdir -p $1
cd $1}

#Open with Text Edit
astxt () {open -e $1}

#Current time UTC
utc () {date -u}

#Get random person on tss list
t1 () {shuf -n 1 ~/bin/tss.team}

#Go to project settings for current project
settings () {open -n -a "Google Chrome" --args "https://boss.prd-itbl.co/settings/project"}

#Get API key
key () {head ~/bin/apiCall.config}

#Get API key
key_userId () {head ~/bin/apiCall_userId.config}

#Open the "All accounts with csm" google doc
arr () {open -n -a "Google Chrome" --args "https://docs.google.com/spreadsheets/d/1kC9nRLxNUXgyLpAUlA-ryJDLo7ne4_gn2CG2x6is6Wg/edit#gid=923017211"} 

#Outputs the deliverability questions that need to be answered to escalate a ticket to deliv
deliv () {echo "Deliverability escalation questions:
 * What's the Project name?
 * Which is the mail stream / channel affected (e.g. marketing or transactional)?
 * Which MTA are they using ( Sparkpost, Amazon SES, Sendgrid or Mailgun)?
 * What are the sending domains?
 * Are they on dedicated or shared IPs?
    * You can check this yourself by going to the client's project, Settings and Sending Platforms / Message Channels   
    * If Dedicated IP, which IP's are they using?
 * Are all campaigns affected or only certain campaigns?
 * Ask for recent campaign IDs (no older than 2 weeks)
 * Do they know when the issue started?
 * Is the issue ongoing or is it now resolved?"}

#Print a read me situation of what command line aliases are in this doc
 help () {echo "\033[0;31mmyprj\033[0m *output project settings info and open template from project in new tab
\033[0;31mhash\033[0m  *256 hash any input. will only accept a single input. spaces/new lines will be ignored
\033[0;31mself\033[0m  *256 hash your own email, can add a number for +# alias
\033[0;31mb2a\033[0m   *change a boss link to an app link to share with customers!
\033[0;31ma2b\033[0m   *change an app link to a boss link for easy boss access!
\033[0;31ma2b_open\033[0m *change an app link to a boss link and open the link!
\033[0;31mblobby\033[0m *follow the prompts to create and open a blobby url! 
      *useful for email esp issues! 
      *automatically opens the blobby url in your default browser
\033[0;31mlog\033[0m   *remove and replace annoying log characters 
      *make more legible - not perfect JSON by any means!! 
      *output and open a text file with the log info in it - allows you to easily compare multiple logs
\033[0;31mcheck_date MM/dd/YYYY\033[0m *check if a given date is x number of days from today - ever wondered if a date was on or after 60 days ago? Today is your lucky day!
\033[0;31mzd\033[0m    *follow the prompts for an "easier" way to search zendesk
\033[0;31me2\033[0m    *create simple e2 queries by following the prompts 
      *enter unhashed email - this will do the work for you! 
      *automatically opens e2 in Google Chrome browser with your search populated!
\033[0;31mkube\033[0m  *same as e2 but for kube! 
      *enter as much or as little info as you'd like & rest!
\033[0;31mvisitors_in_node\033[0m *get visitors in a journey tile
\033[0;31mapi_call\033[0m *make simple API calls to test in your project
\033[0;31mkafka\033[0m *check ingestion delay on a specific cluster
\033[0;31mlist\033[0m *opens a list
\033[0;31mcampaign\033[0m *opens a campaign
\033[0;31mjourney\033[0m *opens a journey
\033[0;31mtemplate\033[0m *opens a template
\033[0;31muser\033[0m *opens a user
\033[0;31msnippet\033[0m *opens a snippet
"
 }

remove_commas () {echo "$1" | sed 's/,//g'}

#Alfred commands, commas accepted
list () {echo "https://boss.prd-itbl.co/segmentation?emailListId=$1" | sed 's/,//g' | xargs open}

campaign () {echo "https://boss.prd-itbl.co/analytics/campaign?campaignId=$1" | sed 's/,//g' | xargs open}

journey () {echo "https://boss.prd-itbl.co/workflows/$1/edit?mode=beta&workflowType=Published" | sed 's/,//g' | xargs open}

template () {echo "https://boss.prd-itbl.co/templates/edit?templateId=$1" | sed 's/,//g' | xargs open}

user () {echo "https://boss.prd-itbl.co/users/profiles/$1/fields" | sed 's/,//g' | xargs open}

snippet () {echo "https://boss.prd-itbl.co/templates/snippet/$1/edit" | sed 's/,//g' | xargs open}

#format as json - must have installed jq. see - https://docs.google.com/document/d/17l1MqJVxqAPsgAaf_-0wfgQTP6JA9jyJp61Ga0pfvaM/edit#heading=h.bd53n49kslf
format_json () {echo '$1' | jq '.'}

#open zendesk ticket with number
ticket () {open -n -a "Google Chrome" --args "https://iterable.zendesk.com/agent/tickets/$1"}

###########################################################
#1. Get to my project - replace with a link to a template in your project!
#myprj
myprj () {open -n -a "Google Chrome" --args "https://boss.prd-itbl.co/templates/editor?templateId=7602693"
echo "$project_info"}

#1.1 My UUID Project
myprj_uuid () {open -n -a "Google Chrome" --args "https://boss.prd-itbl.co/templates/snippet/114303/edit"
echo "Cluster ID: 24
Project ID: 19266
Organization ID: 1344"}


#2. Hash 256 - output SHA-256 given any single input
#hash <email>
hash () {echo -n "$1" | shasum -a 256 | awk '{print $1}'}

self () {if [ $# -eq 0 ]; then
echo -n "$email" | shasum -a 256 | awk '{print $1}'
else
email_root=$(echo "$email" | awk -F@ '{print $1}')
echo -n "$email_root+$1@iterable.com" | shasum -a 256  | awk '{print $1}'
fi}

#4. boss url to app url
#b2a <boss link>
b2a () {echo -n "$1\n" | sed 's/boss.prd-itbl.co/app.iterable.com/g'}

#4.1 app url to boss url
#a2b <app link>
a2b () {echo -n "$1\n" | sed 's/app.iterable.com/boss.prd-itbl.co/g'}

#4.2 app url to boss url and open in new tab
a2b_open () {echo -n "$1\n" | sed 's/app.iterable.com/boss.prd-itbl.co/g' | xargs open}

#5. make blobby url and open page
#blobby
blobby () {bash ~/bin/blobby.zsh}

#6. make log_<date>.txt file - take kubernetes log and output it to a more legible format,
#create a text file and open the text file
#log <paste log text here>
log () {echo "$@" | sed -e 's/{/{\n/g' -e 's/}/}\n/g' -e 's/,/,\n/g' -e 's/\\//g' >> log_$(date +"%Y%m%d%H%M%S").txt
file=$(ls -t | head -n1)
echo "New file: $file"
open $file
}

#7. get number of days away a given date is
check_date () {
today=$(date +%s)
#If you like dd/MM/YYYY formt, uncomment out the line below and comment out the uncommented date line
#date=$(date -jf '%d/%m/%Y %H:%M:%S' "$1 00:00:00" "+%s")
date=$(date -jf '%m/%d/%Y %H:%M:%S' "$1 00:00:00" "+%s")
days_since=$(echo "($today-$date)/86400" | bc)
if [ $days_since -lt 0 ]
then
  echo "$1 is in $((-days_since)) days"
elif [ $days_since -gt 0 ]
then
  echo "$1 is $days_since days ago"
else
  echo "$1 is within 1 day"
fi
}

#8. write simple ZD queries
zd () {
  bash ~/bin/zd.zsh
}

#9. write simple E2 queries
e2 () {
  bash ~/bin/e2.zsh
}

#10. write simple Kubes queries
kube () {
  bash ~/bin/kube.zsh
}

#11. get visitors in a workflow
visitors_in_node () {
  bash ~/bin/visitors_in_workflow_node.zsh
}

#12. make simple API calls to your project
api_call () {
  bash ~/bin/apiCall.zsh
}

#13. open datadog kafka dashboard
kafka () {
  bash ~/bin/kafka.zsh
}

#14. format json
format_json () {
  bash ~/bin/jsonFormat.zsh
}

#15. kubes log file to json
log2json () {
  bash ~/bin/log2json.zsh
}
