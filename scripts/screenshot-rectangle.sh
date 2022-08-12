#!/bin/bash

currentDateTime=`date +"%Y-%m-%d--%H-%M-%S"`
filePath="$(xdg-user-dir PICTURES)/screenshots/$currentDateTime.jpg"

# Take a screenshot of the focused sway output
grim -g "$(slurp)" $filePath

# Emit a notification
notify-send 'Screenshot saved' $filePath

