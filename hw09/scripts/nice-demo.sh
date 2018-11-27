#!/bin/bash
options=("-n -20" "-n 0" "-n 19")
options_len=${#options[@]}
for (( i=0; i<${options_len}; i++ ));
do
/usr/bin/time -f "%E %C" --output=time.mi$i  nice  ${options[$i]} ./nice-task.sh  &
done
wait
echo -e "time    command"
cat time.*  | sort
rm time.*
