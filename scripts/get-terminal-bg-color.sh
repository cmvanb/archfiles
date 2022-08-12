#!/bin/bash

# Source:
# https://stackoverflow.com/questions/2507337/how-to-determine-a-terminals-background-color

oldstty=$(stty -g)

# What to query?
# 11: text background
Ps=${1:-11}

stty raw -echo min 0 time 0
printf "\033]$Ps;?\033\\"

# xterm needs the sleep (or "time 1", but that is 1/10th second).
sleep 0.00000001
read -r answer

result=${answer#*;}
stty $oldstty

# Remove escape at the end.
echo $result | sed 's/[^rgb:0-9a-f/]\+$//'
