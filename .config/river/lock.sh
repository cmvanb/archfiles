#!/bin/bash

#-------------------------------------------------------------------------------
# Lock the computer using waylock
#-------------------------------------------------------------------------------

source "$XDG_CONFIG_HOME/theme/theme.sh"

waylock -init-color $(colors_zerox $black) -input-color $(colors_zerox $primary_6) -fail-color $(colors_zerox $d1_red)

