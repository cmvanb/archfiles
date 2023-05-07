#!/bin/bash
#-------------------------------------------------------------------------------
# Fetch password from Bitwarden
#-------------------------------------------------------------------------------

set -o nounset
set -o pipefail

wlr-randr --output DP-3 --transform 90
wlr-randr --output DP-3 --pos 0,0

wlr-randr --output DP-2 --transform normal
wlr-randr --output DP-2 --pos 1200,0

