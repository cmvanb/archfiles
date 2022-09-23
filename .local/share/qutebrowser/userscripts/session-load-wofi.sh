#!/bin/bash

# List the qutebrowser sessions, one per line, add slash to directories to differentiate from files
# Filter out autosave
# Filter out directories
# Strip YAML extension
# Pass output to wofi to select a session
session=$(ls -1p $XDG_DATA_HOME/qutebrowser/sessions/ | rg -v "_autosave" | rg -v "/" | sed 's/\.yml//g' | wofi --show dmenu)

if [ "$session" != "" ]; then
    echo ":session-load ${session}" >> "$QUTE_FIFO"
fi

