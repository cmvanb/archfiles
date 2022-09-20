# Rename this file to match the name of the function
# e.g. ~/.config/fish/functions/n.fish
# or, add the lines to the 'config.fish' file.

function nnn --wraps nnn --description 'support nnn quit and change directory'
    # Block nesting of nnn in subshells
    if test -n "$NNNLVL"
        if [ (expr $NNNLVL + 0) -ge 1 ]
            echo "nnn is already running"
            return
        end
    end

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "-x" from both lines below,
    # without changing the paths.
    if test -n "$XDG_CONFIG_HOME"
        set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
    else
        set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
    end

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    set -x NNN_PLUG "p:preview-tui"

    set _block_device 02
    set _char_device 03
    set _directory 0c
    set _executable 0a
    set _regular 07
    set _hard_link 05
    set _sym_link 0e
    set _missing_details 1f
    set _orphan_link 01
    set _fifo 0d
    set _socket 0b
    set _unknown 09
    set -x NNN_FCOLORS $_block_device$_char_device$_directory$_executable$_regular$_hard_link$_sym_link$_missing_details$_orphan_link$_fifo$_socket$_unknown

    set -x NNN_COLORS '#0c0a0b0d'

    # set -x NNN_OPENER "$XDG_CONFIG_HOME/nnn/plugins/nuke"

    # The command function allows one to alias this function to `nnn` without
    # making an infinitely recursive alias

    # `nnn` Options
    # d: Show file details.
    # U: Show user and group names in statusbar.
    # a: Create a new FIFO path for each instance (enables multiple instances of nnn using FIFO).
    command nnn -d -U -a $argv

    # NOTE: `nnn` leaves a messy terminal behind, so we `clear` it. This may be
    # undesirable as we lose terminal scrollback...
    clear

    if test -e $NNN_TMPFILE
        source $NNN_TMPFILE
        rm $NNN_TMPFILE
    end
end
