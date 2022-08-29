#-------------------------------------------------------------------------------
# Fish configuration
#-------------------------------------------------------------------------------

set -g fish_greeting ""

source $HOME/.config/shell/fish/env.fish

if status is-login
    source $HOME/.config/shell/fish/login.fish

    function on_exit --on-event fish_exit
        source $HOME/.config/shell/fish/logout.fish
    end
end

if status is-interactive
    source $HOME/.config/shell/fish/interactive.fish
end


# Remove the default greeting
# set -U fish_greeting

#-------------------------------------------------------------------------------
# Environment variables
#-------------------------------------------------------------------------------

# User XDG directories
# set -q XDG_CONFIG_HOME || set -x XDG_CONFIG_HOME $HOME/.config
# set -q XDG_CACHE_HOME || set -x XDG_CACHE_HOME $HOME/.cache
# set -q XDG_DATA_HOME || set -x XDG_DATA_HOME $HOME/.local/share
# set -q XDG_STATE_HOME || set -x XDG_STATE_HOME $HOME/.local/state

# GNU readline configuration
# set -x INPUTRC $XDG_CONFIG_HOME/readline/config

# Use neovim as text editor
# set -x EDITOR /usr/bin/nvim
# set -x VISUAL /usr/bin/nvim

# Provide ssh-agent socket
# set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.sock

# NOTE: This should be in a bash configuration file.
# Save bash history
# set -x HISTFILE $XDG_DATA_HOME/bash/.bash_history

# Save less history
# set -x LESSHISTFILE $XDG_DATA_HOME/less/.histfile

#-------------------------------------------------------------------------------
# Abbreviations
#-------------------------------------------------------------------------------

# abbr -a gs git status
# abbr -a gl 'git log --pretty=\'%C(yellow)[%h]%C(reset) %<(16,trunc)%ad %C(cyan)%an%C(reset) %C(green)%s%C(reset)\' --date=format:\'%Y-%m-%d %H:%M\''
# abbr -a gd git diff
# abbr -a gds git diff --staged
# abbr -a ga git add
# abbr -a gaa git add -A
# abbr -a gc git commit -m
# abbr -a gca git commit --amend
# abbr -a gp git push
# abbr -a gpf git push --force
# abbr -a grc git rm --cached
# abbr -a n nvim
# abbr -a nv nvim
# abbr -a nvi nvim
# abbr -a e exa
# abbr -a ex exa

#-------------------------------------------------------------------------------
# Bindings
#-------------------------------------------------------------------------------

# # Unbind unwanted defaults
# bind \cx true
#
# # Basic bindings (many are already default)
# bind \e cancel # Escape
#
# bind \e\[A up-or-search # Up
# bind \e\[B down-or-search # Down
#
# bind \e\[D backward-char # Left
# bind \e\[C forward-char # Right
#
# bind \e\[1\;5C forward-word # Ctrl + Right
# bind \e\[1\;5D backward-word # Ctrl + Left
#
# bind \e\[H beginning-of-line # Home
# bind \e\[F end-of-line # End
#
# bind -k dc delete-char # Delete
# bind -k backspace backward-delete-char
#
# bind \t complete # Tab
# bind \r execute # Enter
#
# bind \cc fish_clipboard_copy
# bind \cv fish_clipboard_paste
#
# bind '' self-insert
# bind ' ' self-insert expand-abbr
# bind ';' self-insert expand-abbr
# bind '|' self-insert expand-abbr
# bind '&' self-insert expand-abbr
# bind ^ self-insert expand-abbr
# bind '>' self-insert expand-abbr
# bind '<' self-insert expand-abbr
# bind ')' self-insert expand-abbr
#
# # TODO: Decide on the following bindings:
# # CTRL + ? -> Clear screen
# # CTRL + ? -> Clear command line
# # bind \cl 'commandline -r ""'
#
# # Expand ... to ../..
# bind . 'expand-dot-to-double-dot'

#-------------------------------------------------------------------------------
# Prompt (https://github.com/IlanCosman/tide)
#-------------------------------------------------------------------------------

# set -g tide_prompt_color_separator_same_color white
# set -g tide_left_prompt_items context time jobs git virtual_env pwd
# set -g tide_right_prompt_items
#
# set -g tide_context_always_display false
# # TODO: Improve color coordination of context
# # NOTE: Can only pass ANSI16 or 24bit colors, fish (via tide) does not accept 256 encoding
# set -g tide_context_bg_color black
# set -g tide_context_color_default white
# set -g tide_context_color_root brred
# set -g tide_context_color_ssh bryellow
#
# set -g tide_jobs_bg_color white
# set -g tide_jobs_color black
#
# set -g tide_time_bg_color black
# set -g tide_time_color blue
#
# set -g tide_git_icon ''
#
# set -g tide_pwd_icon ''
# set -g tide_pwd_icon_home ''

