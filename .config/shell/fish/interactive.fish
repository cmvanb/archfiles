#-------------------------------------------------------------------------------
# Fish interactive configuration
#
# Unfortunately, it's not trivial to source a POSIX shell script from fish, so
# some parts of the generic script may need to be duplicated here.
#
# NOTE: Although `bass` works, it degrades performance to an unacceptable level.
#   `bass 'source /home/casper/.config/shell/generic/interactive'`
#-------------------------------------------------------------------------------

# NOTE: Currently, the generic interactive script *can* be sourced.
source $XDG_CONFIG_HOME/shell/generic/interactive

#-------------------------------------------------------------------------------
# Import system colors
#-------------------------------------------------------------------------------

source $XDG_CONFIG_HOME/colors/fish-colors.fish

parse_colors

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
abbr -a exa exa -al

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

set -U tide_prompt_color_separator_same_color (color_named 'white')
set -U tide_left_prompt_items context time jobs git virtual_env pwd
set -U tide_right_prompt_items

set -U tide_context_always_display false
set -U tide_context_bg_color (color_named 'd2_gray')
set -U tide_context_color_default (color_named 'white')
set -U tide_context_color_root (color_named 'red')
set -U tide_context_color_ssh (color_named 'yellow')

set -U tide_time_format '%H:%M:%S'
set -U tide_time_bg_color (color_named 'black')
set -U tide_time_color (color_named 'cyan')

set -U tide_jobs_icon ''
set -U tide_jobs_bg_color (color_named 'red')
set -U tide_jobs_color (color_named 'black')

set -U tide_git_icon ''
set -U tide_git_bg_color (color_named 'green')
set -U tide_git_bg_color_unstable (color_named 'yellow')
set -U tide_git_bg_color_urgent (color_named 'red')

# TODO: Configure virtualenv module.

set -U tide_pwd_icon ''
set -U tide_pwd_icon_home ''
set -U tide_pwd_icon_unwritable ''
set -U tide_pwd_bg_color (color_named 'blue')
set -U tide_pwd_color_anchors (color_named 'l1_white')
set -U tide_pwd_color_dirs (color_named 'l1_white')
set -U tide_pwd_color_truncated_dirs (color_named 'white')

