# WARNING: if you delete .bash_profile, this file becomes part of bash's startup
# sequence, which means this file suddenly has to cater for two different
# shells.

echo 'Hello world from `.profile` !'

. ~/.config/shell/sh/env
. ~/.config/shell/sh/login

