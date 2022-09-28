#!/bin/bash

#-------------------------------------------------------------------------------
# Convert a terminal color index (0-15) to an ANSI terminal escape sequence.
#
# Useful for pretty printing.
#-------------------------------------------------------------------------------

script_name=`basename "$0"`

print_usage() {
    echo "$script_name [--bg=15] [--fg=0] [--reset]" >&2
    echo "" >&2
    echo "--bg: Set the terminal background color. Expects a terminal color index, from 0 to 15." >&2
    echo "--fg: Set the terminal foreground color. Expects a terminal color index, from 0 to 15." >&2
    echo "--reset: Reset the terminal colors to default. Will override --bg and --fg." >&2
    echo "" >&2
    echo "Examples:" >&2
    echo "$script_name --bg=15 --fg=0" >&2
    echo "$script_name --fg=2" >&2
}

background_color=""
foreground_color=""
reset=0
while getopts ":-:" optchar; do
    [[ "${optchar}" == "-" ]] || continue
    case "${OPTARG}" in
        bg=* )
            background_color=${OPTARG#*=}
            ;;
        fg=* )
            foreground_color=${OPTARG#*=}
            ;;
        reset )
            reset=1
            ;;
        help )
            print_usage
            exit -1
            ;;
    esac
done

# TODO: Consider handling the case of too many arguments.

# Remove from the list of arguments the one already handled by getopts
# shift $(($OPTIND - 1))
#
# if [[ $# -ne 1 ]]; then
#     echo "Wrong number of arguments." >&2
#     print_usage
#     exit -1
# fi

if [[ -n $background_color ]]; then
    if (( 0 <= $background_color && $background_color <= 7 )); then
        color_value="$((40 + $background_color))"
        printf "\e[1;34;%dm" $color_value
    fi
    if (( 8 <= $background_color && $background_color <= 15 )); then
        color_value="$((100 + $background_color - 8))"
        printf "\e[1;34;%dm" $color_value
    fi
fi

if [[ -n $foreground_color ]]; then
    if (( 0 <= $foreground_color && $foreground_color <= 7 )); then
        color_value="$((30 + $foreground_color))"
        printf "\e[1;34;%dm" $color_value
    fi
    if (( 8 <= $foreground_color && $foreground_color <= 15 )); then
        color_value="$((90 + $foreground_color - 8))"
        printf "\e[1;34;%dm" $color_value
    fi
fi

if [[ $reset -eq 1 ]]; then
    printf "\e[0m"
fi

