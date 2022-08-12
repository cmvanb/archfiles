#-------------------------------------------------------------------------------
# Fish configuration
#-------------------------------------------------------------------------------

# Universal config
# TODO: Consider moving this to upstream of river
set PATH /home/casper/bin $PATH

# Interactive-only config below
if not status is-interactive
    exit
end

# Remove the default greeting
set -U fish_greeting

#-------------------------------------------------------------------------------
# Environment variables
#-------------------------------------------------------------------------------

set -q XDG_CONFIG_HOME || set -x XDG_CONFIG_HOME $HOME/.config
set -q XDG_CACHE_HOME || set -x XDG_CACHE_HOME $HOME/.cache
set -q XDG_DATA_HOME || set -x XDG_DATA_HOME $HOME/.local/share
set -q XDG_STATE_HOME || set -x XDG_STATE_HOME $HOME/.local/state

# GNU readline configuration
set -x INPUTRC $XDG_CONFIG_HOME/readline/config

# Use neovim as text editor
set -x EDITOR /usr/bin/nvim
set -x VISUAL /usr/bin/nvim

# Provide ssh-agent socket
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.sock

# Save bash history
set -x HISTFILE $XDG_DATA_HOME/bash/.bash_history

# Save less history
set -x LESSHISTFILE $XDG_DATA_HOME/less/.histfile

#-------------------------------------------------------------------------------
# Abbreviations
#-------------------------------------------------------------------------------

abbr -a gs git status
abbr -a gl 'git log --pretty=\'%C(yellow)[%h]%C(reset) %<(16,trunc)%ad %C(cyan)%an%C(reset) %C(green)%s%C(reset)\' --date=format:\'%Y-%m-%d %H:%M\''
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a ga git add
abbr -a gaa git add -A
abbr -a gc git commit -m
abbr -a gca git commit --amend
abbr -a gp git push
abbr -a gpf git push --force
abbr -a grc git rm --cached
abbr -a n nvim
abbr -a nv nvim
abbr -a nvi nvim
abbr -a e exa
abbr -a ex exa

#-------------------------------------------------------------------------------
# Bindings
#-------------------------------------------------------------------------------

# Don't use vi key bindings
fish_default_key_bindings

# Ctrl-Q clears the command line
bind \cq 'commandline -r ""'

# Expand ... to ../..
bind . 'expand-dot-to-double-dot'

#-------------------------------------------------------------------------------
# Prompt (https://github.com/IlanCosman/tide)
#-------------------------------------------------------------------------------

set -U tide_prompt_color_separator_same_color white
set -U tide_left_prompt_items context time jobs git virtual_env pwd
set -U tide_right_prompt_items

set -U tide_context_always_display false
# TODO: Improve color coordination of context
# NOTE: Can only pass ANSI16 or 24bit colors, fish (via tide) does not accept 256 encoding
set -U tide_context_bg_color black
set -U tide_context_color_default white
set -U tide_context_color_root brred
set -U tide_context_color_ssh bryellow

set -U tide_time_bg_color black
set -U tide_time_color blue

set -U tide_git_icon ''

set -U tide_pwd_icon ''
set -U tide_pwd_icon_home ''

