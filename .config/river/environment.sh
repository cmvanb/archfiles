#!/bin/sh

# Tells libseat what login daemon we're using so it doesn't have to cry about it.
export LIBSEAT_BACKEND=logind

# QT performance flag.
export QT_QPA_PLATFORM=wayland

# XDG integration, this may be unnecessary.
export XDG_CURRENT_DESKTOP=river
export XDG_SESSION_DESKTOP=river
