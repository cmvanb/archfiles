#!/bin/bash

#-------------------------------------------------------------------------------
# Lock the computer using waylock
#-------------------------------------------------------------------------------

source "$XDG_CONFIG_HOME/theme/theme.sh"

waylock -init-color $(color_zerox $black) -input-color $(color_zerox $primary_12) -fail-color $(color_zerox $d1_red)

