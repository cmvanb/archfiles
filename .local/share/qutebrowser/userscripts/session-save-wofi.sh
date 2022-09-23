#!/bin/bash

. $HOME/scripts/name-formatting.sh

# List the qutebrowser sessions, one per line, add slash to directories to differentiate from files
# Filter out autosave
# Filter out directories
# Strip YAML extension
# Pass output to wofi to select a session
input=$(ls -1p $XDG_DATA_HOME/qutebrowser/sessions/ | rg -v "_autosave" | rg -v "/" | sed 's/\.yml//g' | wofi --show dmenu)

session=$(convert_to_kebab_case $input)

if [ "$session" != "" ]; then
    echo ":session-save -o ${session}" >> "$QUTE_FIFO"
fi

