#-------------------------------------------------------------------------------
# Fish interactive configuration
#
# Unfortunately, it's not trivial to source a POSIX shell script from fish, so
# some parts of the generic script may need to be duplicated here.
#
# NOTE: Although `bass` works, it degrades performance to an unacceptable level.
#   `bass 'source /home/casper/.config/shell/generic/interactive'`
#-------------------------------------------------------------------------------

# NOTE: In it's present form, the generic interactive script *can* be sourced.
# That may not always be true.
source $XDG_CONFIG_HOME/shell/generic/interactive

# Aliases & Abbreviations
#-------------------------------------------------------------------------------

# NOTE: These are Arch specific... needs cleaner separation.
alias sysyadm "sudo yadm --yadm-dir /etc/yadm --yadm-data /etc/yadm/data"
alias yaya "yay -S --removemake --answerclean All --answerdiff None --noconfirm"

alias edit "$EDITOR"
alias exa "exa -l --group-directories-first"

abbr -a gs git status
abbr -a gsu git status -u
abbr -a gl 'git log --pretty=\'%C(yellow)[%h]%C(reset) %<(16,trunc)%ad %C(cyan)%an%C(reset) %C(green)%s%C(reset)\' --date=format:\'%Y-%m-%d %H:%M\''
abbr -a gd git diff
abbr -a gds git diff --staged
abbr -a ga git add
abbr -a gaa git add -A
abbr -a gc git commit -m
abbr -a gca git commit --amend
abbr -a gco git checkout
abbr -a gp git push
abbr -a gpa git push --all
abbr -a gpf git push --force
abbr -a grb git rebase -i
abbr -a grc git rm --cached
abbr -a e edit
abbr -a ed edit
abbr -a edi edit
abbr -a ex exa
abbr -a lf lfcd
abbr -a ls exa
abbr -a lsa exa -a
abbr -a lst exa -T --git-ignore
abbr -a lsat exa -aT --git-ignore
abbr -a ip ip -c

# Bindings
#-------------------------------------------------------------------------------

# Unbindings
bind \cb ''

# lfcd
bind \cf 'lfcd; commandline -f repaint'

# nvim
bind \ce 'edit; commandline -f repaint'

# Clear screen
bind \cl 'clear; commandline -f repaint'

# Clear command line
# NOTE: Ctrl+C is bound to `Copy` by Wezterm, Ctrl+X is bound to emulate
# Ctrl+C, which is what fish picks up here.
bind \cc 'commandline -r ""'

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
bind '' self-insert
bind ' ' self-insert expand-abbr
bind ';' self-insert expand-abbr
bind '|' self-insert expand-abbr
bind '&' self-insert expand-abbr
bind '>' self-insert expand-abbr
bind '<' self-insert expand-abbr
bind ')' self-insert expand-abbr

# Expand ... to ../..
bind . 'expand-dot-to-double-dot'

# Colors
# see: https://fishshell.com/docs/current/interactive.html#color
#-------------------------------------------------------------------------------

# Import and parse system colors.
source $XDG_CONFIG_HOME/theme/theme.fish

set -U fish_color_autosuggestion (color_named 'text_8')
set -U fish_color_command (color_named 'ansi_cyan')
set -U fish_color_comment (color_named 'secondary_5')
set -U fish_color_end (color_named 'green_4') # pipe
set -U fish_color_error (color_named 'ansi_red')
set -U fish_color_normal (color_named 'text_12') # search: text
set -U fish_color_operator (color_named 'green_4')
set -U fish_color_option (color_named 'ansi_bryellow')
set -U fish_color_param (color_named 'secondary_12')
set -U fish_color_quote (color_named 'ansi_yellow')
set -U fish_color_redirection (color_named 'ansi_brmagenta')
set -U fish_color_search_match --background=(color_named 'l1_magenta')
set -U fish_color_valid_path (color_named 'ansi_brcyan') --bold #--underline

set -U fish_pager_color_completion (color_named 'text_8')
set -U fish_pager_color_description (color_named 'text_12')
set -U fish_pager_color_prefix (color_named 'yellow_5')
set -U fish_pager_color_progress (color_named 'green_4')
set -U fish_pager_color_selected_background --background=(color_named 'primary_7')
set -U fish_pager_color_selected_completion (color_named 'text_15')
set -U fish_pager_color_selected_description (color_named 'text_15')

# TODO: Find where these colors are used by fish.
set -U fish_color_escape (color_named 'debug')
set -U fish_color_cancel (color_named 'debug') # -r
set -U fish_color_history_current (color_named 'debug') # --bold
set -U fish_color_selection (color_named 'debug') # --bold --background=brblack

# LF CD integration
#-------------------------------------------------------------------------------

source $HOME/.scripts/lfcd.fish

# Prompt
#   see: https://github.com/IlanCosman/tide
#-------------------------------------------------------------------------------

# Separators
set -U tide_left_prompt_separator_diff_color ''
set -U tide_left_prompt_separator_same_color ''
# set -U tide_prompt_color_separator_same_color (color_named 'debug')

# Items
set -U tide_left_prompt_items time context jobs git virtual_env pwd
set -U tide_right_prompt_items

# Context (user@hostname)
set -U tide_context_always_display false
set -U tide_context_bg_color (color_named 'gray_1')
set -U tide_context_color_default (color_named 'text_15')
set -U tide_context_color_root (color_named 'red_7')
set -U tide_context_color_ssh (color_named 'yellow_7')

# Time
set -U tide_time_format '%H:%M:%S'
set -U tide_time_bg_color (color_named 'primary_6')
set -U tide_time_color (color_named 'text_12')

# Background jobs
set -U tide_jobs_icon ''
set -U tide_jobs_bg_color (color_named 'ansi_red')
set -U tide_jobs_color (color_named 'ansi_black')

# Git
set -U tide_git_icon ''
set -U tide_git_bg_color (color_named 'green_4')
set -U tide_git_bg_color_unstable (color_named 'orange_6')
set -U tide_git_bg_color_urgent (color_named 'ansi_red')
# NOTE: Listed in tide documentation, but has no effect.
# set -U tide_git_color_branch (color_named 'debug')
set -U tide_git_color_operation (color_named 'gray_0')
set -U tide_git_color_upstream (color_named 'gray_0')
set -U tide_git_color_stash (color_named 'gray_0')
set -U tide_git_color_conflicted (color_named 'gray_0')
set -U tide_git_color_staged (color_named 'gray_0')
set -U tide_git_color_dirty (color_named 'gray_0')
set -U tide_git_color_untracked (color_named 'gray_0')

# Python virtual environment
set -U tide_virtual_env_icon ''
set -U tide_virtual_env_bg_color (color_named 'ansi_magenta')
set -U tide_virtual_env_color (color_named 'ansi_bryellow')

# Working directory
set -U tide_pwd_icon ''
set -U tide_pwd_icon_home ''
set -U tide_pwd_icon_unwritable ''
set -U tide_pwd_bg_color (color_named 'primary_6')
set -U tide_pwd_color_anchors (color_named 'text_15')
set -U tide_pwd_color_dirs (color_named 'text_12')
set -U tide_pwd_color_truncated_dirs (color_named 'text_12')

# Python environment
#-------------------------------------------------------------------------------
if command -v pyenv &> /dev/null
    pyenv init - | source
end

