#!/bin/sh

for file in *; do
    $HOME/.scripts/rename-kebabcase.sh "$file"
done

