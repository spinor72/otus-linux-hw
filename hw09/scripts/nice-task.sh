#!/bin/bash
for (( i=0; i<10000; i++ ));
do
echo $i | sha512sum | sha512sum | sha512sum  >/dev/null
done
