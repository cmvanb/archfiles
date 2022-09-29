#!/bin/bash

#-------------------------------------------------------------------------------
# Print terminal colors and indices.
#
# NOTE: Color index assignments are defined by the terminal emulator.
#
# Copyright (c) 2016 Tom Hale

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#-------------------------------------------------------------------------------

# Fail on errors or undeclared variables.
set -eu 

max_printable_colors=256

# Based on the input color index, return a contrasting color index.
# NOTE: This is hard coded, no actual contrast/luminance calculation is done.
function contrast_color {
    color="$1"

    # ANSI colors
    if (( color < 16 )); then
        (( color == 0 )) && printf "7" || printf "0"
        return
    fi

    # Customized color bands
    if (( color >= 16 )) && (( color < 106 )); then
        band_base=$(( (color - 5) / 10 ))
        band_max=$(( (band_base * 10) + 15 ))
        band_index=$(( (color - 6) % 10 ))

        (( band_index < 4 )) && printf "$band_max" || printf "0"
        return
    fi

    # Unused colors
    printf "8"
}

# Print a colored block with the number of that color.
function print_color {
    local color="$1" index
    index=$(contrast_color "$1")

    # Color block
    printf "\e[48;5;%sm" "$color"

    # Contrasted index text
    printf "\e[38;5;%sm%3d" "$index" "$color"

    # Reset
    printf "\e[0m"
}

# Starting at $1, print a band of $2 colors.
function print_band {
    local i
    for (( i = "$1"; i < "$1" + "$2" && i < max_printable_colors; i++ )) do
        print_color "$i"
    done
    printf "  "
}

# Print ANSI colors.
print_band 0 8
printf "\n"
print_band 8 8
printf "\n"

printf "\n"

# Print customized color bands.
print_band 16 10
printf "\n"
print_band 26 10
printf "\n"
print_band 36 10
printf "\n"
print_band 46 10
printf "\n"
print_band 56 10
printf "\n"
print_band 66 10
printf "\n"
print_band 76 10
printf "\n"
print_band 86 10
printf "\n"
print_band 96 10
printf "\n"

# Print unused colors.
# print_band 106 255
# printf "\n"

