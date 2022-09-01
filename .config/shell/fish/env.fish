#-------------------------------------------------------------------------------
# Generic environment configuration
#
# This should work exactly the same as ~/.config/shell/generic/env.
# Unfortunately, it's not trivial to source a POSIX shell script from fish, so
# the functionality is duplicated here.
#
# NOTE: Although `bass` works, it degrades performance to an unacceptable level.
#   `bass 'source /home/casper/.config/shell/generic/env'`
#-------------------------------------------------------------------------------

# We need to set $ENV so that if you use shell X as your login shell, and then
# start "sh" as a non-login interactive shell the startup scripts will
# correctly run.
set -x ENV $HOME/.config/shell/sh/interactive

# We also need to set BASH_ENV, which is run for *non-interactive* shells.
# (unlike $ENV, which is for interactive shells)
set -x BASH_ENV $HOME/.config/shell/bash/env

# No write permissions for group or others.
umask 0022

