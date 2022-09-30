#!/bin/bash

. ~/.config/colors/colors

# Does nothing
colors () {
    echo -n $1
}

# Usage: `"$(colors_zerox $colorname)"`
colors_hash () {
    echo -n \#${1:1}
}

# Usage: `"$(colors_zerox $colorname)"`
colors_zerox () {
    echo -n 0x${1:1}
}

