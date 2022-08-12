#!/bin/bash

# functions
bw_abort ()
{
    # always lock and logout
    bw_finalize

    exit $1
}

bw_finalize ()
{
    bw lock

    bw logout
}

# input validation
if [[ -z $1 ]] ; then
    echo 'Missing parameter: TARGET'
    exit 1
fi

TARGET=$1

# retrieve secrets
. ~/.secrets

if [[ -z $BW_CLIENTID ]] ; then
    echo 'Missing secret: BW_CLIENTID'
    exit 2
fi

if [[ -z $BW_CLIENTSECRET ]] ; then
    echo 'Missing secret: BW_CLIENTSECRET'
    exit 3
fi

# login to bitwarden CLI with personal API key
BW_CLIENTID=$BW_CLIENTID BW_CLIENTSECRET=$BW_CLIENTSECRET bw login --apikey

if [[ $? -ne 0 ]] ; then
    bw_abort 4
fi

# require master password
SESSION_KEY=$(bw unlock)

if [[ $? -ne 0 ]] ; then
    bw_abort 5
fi

# retrieve target password with session key
RESULT=$(bw get password $TARGET --session $SESSION_KEY)

if [[ $? -ne 0 ]] ; then
    bw_abort 6
fi

# always lock and logout
bw_finalize

# copy final result to clipboard
wl-copy $RESULT

echo 'Password for '\'''$TARGET''\'' is in Wayland clipboard'

