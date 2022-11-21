#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

. $HOME/scripts/name-formatting.sh

SRC_FILENAME="${1%.*}"
SRC_FILE_EXT="${1##*.}"

if [[ -f "$1" ]]; then
    DST_FILENAME=$(convert_to_kebab_case "$SRC_FILENAME")".$SRC_FILE_EXT"
    mv "$1" "$DST_FILENAME"
else
    echo "File does not exist." 1>&2; exit 1
fi

