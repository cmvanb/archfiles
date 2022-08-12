#!/bin/bash

set_terminal_bg_color() {
    local COLOR="$1"

    echo -ne "\\033]11;#$COLOR\\007"
}

set_terminal_bg_color $1

