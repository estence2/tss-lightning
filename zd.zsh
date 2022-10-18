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
"Shane.Williams@iterable.com"
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
)
#ask for assignee name
read -p "Acceptable formats include:
1. First
2. Last
3. First Last
Enter name of tss agent or press enter to skip: " first last
#iterate over tss_array
for val in "${tss_array[@]}";
do
  if [[ $val = "$first"* ]]; then
    echo "$val matched $first query"
  fi
done

#if (( $tss_array[(0)"Michael"] ));
#then
#  echo "$first $last is in the array!"
#else
#  echo "you don't know how to write this function"
#fi
