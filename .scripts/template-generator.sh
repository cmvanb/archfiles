#!/bin/sh
#-------------------------------------------------------------------------------
# Template generator for configuration files
#-------------------------------------------------------------------------------

set -o errexit
set -o pipefail
set -o nounset
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

# Directory in which to look for templates.
target_directory=$XDG_CONFIG_HOME

# Get all variables, before we source the theme vars.
set_before=$( set -o posix; set | sed -e '/^_=*/d' )

source $XDG_CONFIG_HOME/theme/colors
source $XDG_CONFIG_HOME/theme/fonts

# Get all variables, including the theme vars.
set_after=$( set -o posix; unset set_before; set | sed -e '/^_=/d' )

# Use diff on the two sets to get the list of theme vars.
vars_diff=$(diff <(echo "$set_before") <(echo "$set_after") || true)
if [[ $? -eq 2 ]]; then
    echo "Diff returned an unexpected error code."
    echo "$vars_diff"
    exit 1
fi

# Clean up the diff output.
theme_vars=$(echo "$vars_diff" | sed -e 's/^> //' -e '/^[[:digit:]].*/d' | sed -e 's/'"'"'//g' -e 's/#//g')

# Export system colors to shell environment.
while IFS= read -r line; do
    export "$line"
done < <(printf '%s\n' "$theme_vars")

echo "Generated:"

# Iterate over all templates in target_directory directory.
for template in $target_directory/**/*.template; do
    file_name=$(echo "$template" | sed -e 's/.template//')

    echo " -> $file_name"

    # Subsitute environment vars and output config files.
    cat $template | envsubst > "$file_name"
done

