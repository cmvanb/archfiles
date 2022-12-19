#!/bin/bash
#-------------------------------------------------------------------------------
# System theme Shell API
#
# All colors and fonts are defined as simple shell variables, therefore the 
# consumer should simply use these variables. This minimal API is purely for 
# convenience.
#-------------------------------------------------------------------------------

source $XDG_CONFIG_HOME/theme/colors
source $XDG_CONFIG_HOME/theme/fonts

# Usage: `"$(colors_zerox $colorname)"`
colors_hash () {
    echo -n \#${1:1}
}

# Usage: `"$(colors_zerox $colorname)"`
colors_zerox () {
    echo -n 0x${1:1}
}

