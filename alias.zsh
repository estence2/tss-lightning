#Alias file to share with team

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

###########################################################
#1. Get to my project - replace with a link to a template in your project!
#myprj
myprj () {open "https://boss.prd-itbl.co/templates/editor?templateId=7157349"
echo "Cluster ID: 24
Project ID: 14523
Organization ID: 1344"}

#2. Hash 256 - output SHA-256 given any single input
#hash <email>
hash () {echo -n "$1" | shasum -a 256 | awk '{print $1}'}

#3. Hash your email - can optionally enter number for alias
#self
self () {if [ $# -eq 0 ]; then
#replace my email with your email
echo -n "ellen.stence@iterable.com" | shasum -a 256 | awk '{print $1}'
else
#replace my email with your email, do not touch: +$1
echo -n "ellen.stence+$1@iterable.com" | shasum -a 256  | awk '{print $1}'
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
