# ------------------------------------------------------------------------------
# Lookup
# ------------------------------------------------------------------------------

function set_color --argument-names key value
    set -g '__color_'$key $value
end

function color_named --argument-names key
    eval echo \$'__color_'$key
end

function color_hash --argument-names key
    echo '#'$(eval echo \$'__color_'$key)
end

function color_zerox --argument-names key
    echo '0x'eval echo \$'__color_'$key)
end

# ------------------------------------------------------------------------------
# Parser
# ------------------------------------------------------------------------------
function parse_colors --argument-names colors_file
    test -z $colors_file && set colors_file "$XDG_CONFIG_HOME/colors/colors"

    while read line
        set -l key ''
        set -l value ''
        set -l assignment_op 'false'
        set -l lookup 'false'

        if test -z $line
            continue
        end

        # for c in (string split '' abc)
        for char in (string split '' $line)

            # Space, keep reading
            if test $char = ' '
                continue

            # Hash after assignment, char is ignored, but continue parsing value.
            # Hash before assignment, line is skipped.
            else if test $char = '#'
                if test $assignment_op = 'true'
                    continue
                else
                    set key ''
                    set value ''
                    break
                end

            # Quote, only allowed after assignment
            else if test $char = '\''
                if test $assignment_op = 'true'
                    continue
                else
                    echo "Unable to continue parsing, expected character [$char] only after assignment."
                    return 2
                end

            # Dollar, only allowed after assignment
            else if test $char = '$'
                if test $assignment_op = 'true'
                    set lookup 'true'
                    continue
                else
                    echo "Unable to continue parsing, expected character [$char] only after assignment."
                    return 3
                end

            # Alphanumeric or underscore or hash, append to either key or value
            else if string match -qr -- '[0-9a-zA-Z_#]' $char
                if test $assignment_op = 'false'
                    set key "$key$char"
                else
                    set value "$value$char"
                end

            # Assignment operator reached, keep reading for value
            else if test $char = '='
                if test $assignment_op = 'false'
                    set assignment_op 'true'
                end

            else
                echo "Unable to continue parsing, unexpected character [$char]."
                return 4

            end
        end

        # Assign value
        if test -n $key && test -n $value
            if test $lookup = 'true'
                set_color $key $(color_named $value)
            else
                set_color $key $value
            end
        end

    end < $colors_file

    return 0
end

