#!/bin/bash
#-------------------------------------------------------------------------------
# Fetch password from Bitwarden
#-------------------------------------------------------------------------------

set -o nounset
set -o pipefail

# Functions
#-------------------------------------------------------------------------------
bw_abort ()
{
    # Always lock and logout.
    bw_finalize
    exit $1
}

bw_finalize ()
{
    bw lock
    bw logout
}

# Input validation
#-------------------------------------------------------------------------------
if [[ -z $1 ]]; then
    echo 'Missing parameter: TARGET' 1>&2
    exit 1
fi

TARGET=$1

# Retrieve secrets
#-------------------------------------------------------------------------------
. ~/.secrets

if [[ -z $BW_CLIENTID ]]; then
    echo 'Missing secret: BW_CLIENTID' 1>&2
    exit 2
fi

if [[ -z $BW_CLIENTSECRET ]]; then
    echo 'Missing secret: BW_CLIENTSECRET' 1>&2
    exit 3
fi

# Login to bitwarden CLI with personal API key
#-------------------------------------------------------------------------------
echo 'Login to Bitwarden'

LOGIN_RESULT=$(BW_CLIENTID=$BW_CLIENTID BW_CLIENTSECRET=$BW_CLIENTSECRET bw login --apikey --raw)

if [[ $? -ne 0 ]]; then
    bw_abort 4
fi

# echo $LOGIN_RESULT
# echo $LOGIN_RESULT =~ "You are already logged in"
#
# if [[ $? -ne 0 ]]; then
#     if [[ LOGIN_RESULT =~ "You are already logged in" ]]; then
#         echo 'Already logged in, continuing.'
#     else
#         echo $LOGIN_RESULT
#         bw_abort 4
#     fi
# fi

# Require master password
#-------------------------------------------------------------------------------
SESSION_KEY=$(bw unlock)
if [[ $? -ne 0 ]]; then
    bw_abort 5
fi

# Retrieve target password with session key
#-------------------------------------------------------------------------------
# RESULT=$(bw get item $TARGET --session $SESSION_KEY)
RESULT=$(bw list items --search $TARGET --session $SESSION_KEY)
if [[ $? -ne 0 ]]; then
    bw_abort 6
fi

ITEMS_COUNT=$(echo $RESULT | jq '. | length')

if [[ $ITEMS_COUNT -gt 1 ]]; then
    printf '\n'
    echo "Found multiple items matching input: \`$TARGET\`." 1>&2
    printf '\n'
    echo "$(echo $RESULT | jq -r '.[] | {name: .name, id: .id} | values[]')" 1>&2
    printf '\n'

    bw_abort 7

elif [[ $ITEMS_COUNT -lt 1 ]]; then
    printf '\n'
    echo "Did not find any items matching input: \`$TARGET\`." 1>&2
    printf '\n'

    bw_abort 8

elif [[ $ITEMS_COUNT -eq 1 ]]; then
    NAME=$(echo $RESULT | jq -r '.[] | .name')
    PASSWORD=$(echo $RESULT | jq -r '.[] | .login.password')

    printf '\n'
    echo 'Found item: '$NAME

    # Copy result to clipboard so we can use it immediately
    wl-copy $PASSWORD

    printf '\n'
    echo 'Password is in Wayland clipboard.'
    printf '\n'
fi

# Always lock and logout
#-------------------------------------------------------------------------------
bw_finalize

