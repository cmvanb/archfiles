#-------------------------------------------------------------------------------
# Generic interactive configuration
#
# This should work exactly the same as ~/.config/shell/generic/interactive
# Unfortunately, it's not trivial to source a POSIX shell script from fish, so
# the functionality is duplicated here.
#
# NOTE: Although `bass` works, it degrades performance to an unacceptable level.
#   `bass 'source /home/casper/.config/shell/generic/interactive'`
#-------------------------------------------------------------------------------

# Setup terminal escape bindings.
stty intr ^X
stty quit ^Q
stty erase undef
stty kill ^K
stty eof ^E
stty start undef
stty stop undef
stty susp undef
stty rprnt undef
stty werase undef
stty lnext undef
stty discard undef

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
abbr -a e edit
abbr -a ed edit

#-------------------------------------------------------------------------------
# Bindings
#-------------------------------------------------------------------------------

# Unbind unwanted defaults
bind \cx true

# Basic bindings (many are already default)
bind \e cancel # Escape

bind \e\[A up-or-search # Up
bind \e\[B down-or-search # Down

bind \e\[D backward-char # Left
bind \e\[C forward-char # Right

bind \e\[1\;5C forward-word # Ctrl + Right
bind \e\[1\;5D backward-word # Ctrl + Left

bind \e\[H beginning-of-line # Home
bind \e\[F end-of-line # End

bind -k dc delete-char # Delete
bind -k backspace backward-delete-char

bind \t complete # Tab
bind \r execute # Enter

bind \cc fish_clipboard_copy
bind \cv fish_clipboard_paste

bind '' self-insert
bind ' ' self-insert expand-abbr
bind ';' self-insert expand-abbr
bind '|' self-insert expand-abbr
bind '&' self-insert expand-abbr
bind ^ self-insert expand-abbr
bind '>' self-insert expand-abbr
bind '<' self-insert expand-abbr
bind ')' self-insert expand-abbr

# Expand ... to ../..
bind . 'expand-dot-to-double-dot'

# TODO: Decide on the following bindings:
# CTRL + ? -> Clear screen
# CTRL + ? -> Clear command line
# bind \cl 'commandline -r ""'

#-------------------------------------------------------------------------------
# Prompt (https://github.com/IlanCosman/tide)
#-------------------------------------------------------------------------------

set -g tide_prompt_color_separator_same_color white
set -g tide_left_prompt_items context time jobs git virtual_env pwd
set -g tide_right_prompt_items

set -g tide_context_always_display false
# TODO: Improve color coordination of context
# NOTE: Can only pass ANSI16 or 24bit colors, fish (via tide) does not accept 256 encoding
set -g tide_context_bg_color black
set -g tide_context_color_default white
set -g tide_context_color_root brred
set -g tide_context_color_ssh bryellow

set -g tide_jobs_bg_color white
set -g tide_jobs_color black

set -g tide_time_bg_color black
set -g tide_time_color blue

set -g tide_git_icon ''

set -g tide_pwd_icon ''
set -g tide_pwd_icon_home ''

