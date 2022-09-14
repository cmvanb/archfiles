#!/bin/bash

. ~/.config/colors/colors

# Does nothing
colors () {
    echo $1
}

# Usage: `"$(colors_zerox $colorname)"`
colors_hash () {
    echo \#${1:1}
}

# Usage: `"$(colors_zerox $colorname)"`
colors_zerox () {
    echo 0x${1:1}
}

