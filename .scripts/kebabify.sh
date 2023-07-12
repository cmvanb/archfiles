#!/bin/bash

for file in *; do
    $HOME/.scripts/rename-kebabcase.sh "$file"
done

