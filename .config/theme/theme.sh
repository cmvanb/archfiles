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

color_named () {
    echo -n ${1:1}
}

# Usage: `$(colors_zerox $colorname)`
# TODO: Rename to singular (`color_` instead of `colors_`) to be consistent with
# other language bindings.
colors_hash () {
    echo -n \#${1:1}
}

# Usage: `$(colors_zerox $colorname)`
# TODO: Rename to singular (`color_` instead of `colors_`) to be consistent with
# other language bindings.
colors_zerox () {
    echo -n 0x${1:1}
}

# Usage: `$(colors_ansi $colorfg $colorbg)`
# TODO: Rename to singular (`color_` instead of `colors_`) to be consistent with
# other language bindings.
colors_ansi () {
    $HOME/.scripts/color-hex-to-ansi.sh --fg=${1:1} --bg=${2:1}
}

# Usage: `$(colors_ansi_fg $colorfg)`
# TODO: Rename to singular (`color_` instead of `colors_`) to be consistent with
# other language bindings.
colors_ansi_fg () {
    $HOME/.scripts/color-hex-to-ansi.sh --fg=${1:1}
}

# Usage: `$(colors_ansi_reset)`
# TODO: Rename to singular (`color_` instead of `colors_`) to be consistent with
# other language bindings.
colors_ansi_reset () {
    $HOME/.scripts/color-hex-to-ansi.sh --reset
}

