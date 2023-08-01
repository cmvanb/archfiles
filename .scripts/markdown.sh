#!/bin/sh

set -o errexit
set -o pipefail
set -o nounset

if [ "$#" -ne 1 ]; then
    echo "Expected only one argument: the filename of the markdown file. Received $# arguments."
    exit 1
fi

filename=$(basename -- "$1")
extension="${filename##*.}"

if [ "$extension" != "md" ]; then
    echo "Expected markdown file with \`md\` extension. Received file with \`$extension\` extension."
    exit 1
fi

outname="${filename%.*}.html"

pandoc -f markdown -t html $filename > $outname
