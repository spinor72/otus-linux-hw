#!/bin/bash
dd_bs=1024
dd_count=10000
options=("-c3" "-c2 -n7"  "-c2 -n0" "-c1 -n7" "-c1 -n0")
options_len=${#options[@]}
for (( i=0; i<${options_len}; i++ ));
do
/usr/bin/time -f "%E %C" --output=time.mi$i  ionice  ${options[$i]} dd if=/dev/zero of=out.$i  bs=$dd_bs count=$dd_count oflag=direct 2> /dev/null &
done
wait
echo -e "time    command"
cat time.*  | sort
rm time.*
rm out.*
