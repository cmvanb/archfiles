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

#-------------------------------------------------------------------------------
# Environment
#
# Put your shell-independent, login environment variables here.
#-------------------------------------------------------------------------------

# Some programs respect these defaults, others are supported by XDG with
# configuration in `.config/mimeapps.list` and `.local/share/applications/`.
set -x BROWSER qutebrowser
set -x EDITOR nvim
set -x PAGER "ov -F"
set -x VISUAL $EDITOR

# Configure systemd pager.
set -x SYSTEMD_PAGERSECURE true

# Configure git pager.
set -x GIT_PAGER "ov -F -X"

# XDG user directories>
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# Provide ssh-agent socket.
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.sock

# Configure pyenv (for dynamically swapping python versions).
set -x PYENV_ROOT $HOME/.pyenv

#-------------------------------------------------------------------------------
# Path
#-------------------------------------------------------------------------------

# Add user binaries to path.
fish_add_path -pP $HOME/.local/bin

# Add pyenv python shims to path.
fish_add_path -pP $PYENV_ROOT/bin

