#!/usr/bin/env zsh
#support team list, current and previous as of 10/17/22
tss_array=(
"Michael.Sermersheim@iterable.com"
"Eric.Martich@iterable.com"
"Michael.Turner@iterable.com"
"Brian.Schlesinger@iterable.com"
"Alex.Shea@iterable.com"
"Andre.Linde@iterable.com"
"Pierce.Morrill@iterable.com"
"Jessica.Eleftheriou@iterable.com"
"Rachel.Wu@iterable.com"
"Jena.Chakour@iterable.com"
"Sarah.Liddle@iterable.com"
"Shanae.Williams@iterable.com"
"Kaylie.Verner@iterable.com"
"Grace.Kiburi@iterable.com"
"Tanwir.Ahmed@iterable.com"
"Leah.Lee@iterable.com"
"Nicholas.Kreps@iterable.com"
"Margaret.Chang@iterable.com"
"Omar.Khan@iterable.com"
"Alfie.Rowett@iterable.com"
"Steven.Jones@iterable.com"
"Chris.Prochnow@iterable.com"
"Eric.Wong@iterable.com"
"Heather.Spoelstra@iterable.com"
"Myron.Pan@iterable.com"
"Rachel.West@iterable.com"
"Mel.Christman@iterable.com"
"Kathy.Trujillo@iterable.com"
"Sara.Cemal@iterable.com"
"Julia.Vaughan@iterable.com"
"Sophie.Mittelstadt@iterable.com"
"Ellie.Soto@iterable.com"
"Fernando.Duarte@iterable.com"
"George.Cochrane@iterable.com"
"Will.Powers@iterable.com"
"Alejandra.Perez@iterable.com"
"Elvis.Landi@iterable.com"
"Cor.Belmont@iterable.com"
"Annalyn.Edano@iterable.com"
"Erin.McCulley@iterable.com"
"Haitham.Elnashar@iterable.com"
"Joshua.Berja@iterable.com"
"Maddie.Santos@iterable.com"
"Neal.Ichinohe@iterable.com"
"Sarah.Mayne@iterable.com"
"Stassi.Carrington@iterable.com"
"Ellen.Stence@iterable.com"
)
#get search terms
read -p "Enter text to search by: " text
read -p "
Exact match? y or n? " match
if [[ $match = "y" ]]; then
  search="\"$text\""
else
  search="$text"
fi
#ask for assignee name
read -p "
Acceptable formats include all or first few characters of:
1. First
2. Last
3. First Last

Enter name of tss agent or press enter to skip: " first last
#if there was input, check array
if [[ -n $first ]]; then
  #correct casing
  first=$(echo "$first" | awk '{print tolower($0)}')
  last=$(echo "$last" | awk '{print tolower($0)}')
  #iterate over tss_array
  for val in "${tss_array[@]}";
  do
    #lowercase list values
    val=$(echo $val | tr '[A-Z]' '[a-z]')
    #if last name exists, we know there were 2 inputs
    if [[ -n $last ]]; then
      if [[ $val = "$first"*."$last"*"@iterable.com" ]]; then
        assignee="assignee:$val"
      fi
    #if there was a single input
    elif [[ -n $first ]]; then
      if [[ $val = *"$first"*"@iterable.com" ]]; then
        assignee="assignee:$val"
      fi
    fi
  done
fi
#ask for org name
read -p "
Enter name of organization or press enter to skip: " org
#if org not blank
if [[ -n $org ]]; then
  organization="organization:\'$org\'"
fi
#get number of days to look back
read -p "
Enter number of days to search back or press enter to skip: " days
if [[ -n $days ]]; then
  search_date=$(date -v -${days}d +%D)
  created="created>$search_date"
fi
#include chats?
read -p "
Include chats? y or n? or press enter to skip: " chats
if [[ -n $chats ]]; then
  if [[ $chats = "n" ]]; then
    include_chats="-subject:chat"
  fi
fi
#final ZD search
echo "
$search $assignee $organization $created $include_chats order_by:created sort:desc type:ticket"
