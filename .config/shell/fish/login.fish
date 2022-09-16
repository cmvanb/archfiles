#-------------------------------------------------------------------------------
# Fish login configuration
#
# This should work exactly the same as ~/.config/shell/generic/login
# Unfortunately, it's not trivial to source a POSIX shell script from fish, so
# the functionality is duplicated here.
#
# NOTE: Although `bass` works, it degrades performance to an unacceptable level.
#   `bass 'source /home/casper/.config/shell/generic/login'`
#-------------------------------------------------------------------------------

# Add user binaries to path
fish_add_path -pP $HOME/bin

# Use neovim as text editor
set -x EDITOR /usr/bin/nvim
set -x VISUAL $EDITOR

# XDG user directories
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# Provide ssh-agent socket
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.sock

