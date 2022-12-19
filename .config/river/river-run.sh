#!/bin/bash

# Load river environment.
source $XDG_CONFIG_HOME/river/environment.sh

# Run river and save session log file.
/usr/bin/river 2> $XDG_DATA_HOME/river/session_log

