#!/bin/bash

. ~/.secrets

# login to bitwarden CLI with personal API key
BW_CLIENTID=$BW_CLIENTID BW_CLIENTSECRET=$BW_CLIENTSECRET bw login --apikey --raw

# require manual entry once
SESSION_KEY=$(bw unlock --raw)

SPOTIFY_USERNAME=$(bw get username spotify --session $SESSION_KEY)
SPOTIFY_PASSWORD=$(bw get password spotify --session $SESSION_KEY)

HOSTNAME=$(hostname)

bw logout

echo Running librespot as background job

LIBRESPOT_LOGFILE=~/.cache/librespot/log

# --ap-port is supplied an invalid port so that librespot will use fallback.
# This hack is needed due to Spotify server failure in my region.
#   See: https://github.com/librespot-org/librespot/issues/972
LIBRESPOT_USERNAME=$SPOTIFY_USERNAME \
LIBRESPOT_PASSWORD=$SPOTIFY_PASSWORD \
librespot \
    -n "Arch Linux: $HOSTNAME" \
    -b 320 \
    --ap-port 9090 \
    &>$LIBRESPOT_LOGFILE &

