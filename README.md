# tss-lightning
This is my MBO for Q3 2022. A series of command line functions that should help the tss team work quick like a fox!

Download ohmyzsh from https://ohmyz.sh/
Save alias.zsh file to ~/.oh_my_zsh/custom

Save other .zsh files to ~/bin/

See MBO google sheets document on full demonstration - 

Aliases included but not limited to:
1. myprj
  *output project settings info and open template from project in new tab
    ***Must change lines 6-9 to reflect your own email address***
3. hash <input>
  *256 hash any input. will only accept a single input. spaces/new lines will be ignored

4. self <optional number>
  *256 hash your own email, can add a number for +# alias
  ***Must change line 4 to reflect your own email address***

5. b2a <url>
  *change a boss link to an app link to share with customers!

4.1 a2b <url>
  *change an app link to a boss link for easy boss access!

5. blobby
  *follow the prompts to create and open a blobby url!
  *useful for email esp issues!
  *automatically opens the blobby url in your default browser

6. log <log text from kube>
  *remove and replace annoying log characters
  *make more legible - not perfect JSON by any means!!
  *output and open a text file with the log info in it - allows you to easily compare multiple logs

7. check_date MM/dd/YYYY
  *if you use dd/MM/YYYY format comment out line 72 and remove comment from line 71
  *check if a given date is x number of days from today - ever wondered if a date was on or after 60 days ago? Today is your lucky day!

8. zd
  *follow the prompts for an "easier" way to search zendesk
 
9. e2
  *create simple e2 queries by following the prompts
  *enter unhashed email - this will do the work for you!
  *automatically opens e2 in Google Chrome browser with your search populated!

10. kube
  *same as e2 but for kube!
  *enter as much or as little info as you'd like & rest!

11. visitors_in_node
  *get visitors in a journey tile

12. api_call
  *make simple API calls to test in your project

13. kafka
  *open datadog kafka dashboard on specified cluster

14. format_json
  *format a json payload as json (like prettier in vscode)
  *requires the jq package to be installed (https://jqlang.github.io/jq/)

15. log2json
  *takes a k8s log and outputs it as a json payload
  *requires the jq package to be installed (https://jqlang.github.io/jq/)
  *will only work for complete logs (not cutoff requests). if your request is cutoff, I suggest you use the `log` command & fix your payload (command 6) and then the `format_json` command (command 14)
