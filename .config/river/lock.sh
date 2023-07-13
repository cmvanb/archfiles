#!/bin/bash

#-------------------------------------------------------------------------------
# Lock the computer using waylock
#-------------------------------------------------------------------------------

source "$XDG_CONFIG_HOME/theme/theme.sh"

waylock -init-color $(color_zerox $gray_0) -input-color $(color_zerox $primary_12) -fail-color $(color_zerox $red_4)

