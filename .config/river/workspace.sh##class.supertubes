#!/bin/bash

#-------------------------------------------------------------------------------
# Workspace configuration
#-------------------------------------------------------------------------------

# Secondary output
#-------------------------------------------------------------------------------
riverctl focus-output next

riverctl spawn "yambar"
riverctl spawn "wezterm"
# riverctl spawn "wezterm start -- fish -i -C \"nvim $HOME/Documents/TODO.md\""

# NOTE: Magic number.
sleep 1.0

# Primary output
#-------------------------------------------------------------------------------
riverctl focus-output previous

riverctl spawn "yambar"
riverctl spawn "wezterm"
