# /data/local/.bashrc: executed by bash(1) for non-login shells.
#

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Enable color
CLICOLOR=1

# set history file path to sdcard
HISTFILE="/mnt/sdcard/.bash_history"

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=131072
HISTFILESIZE=1048576

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# NOTE:: !! not sure this works on android
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
# NOTE:: !! not sure this works on android.
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Command prompt
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
# Red prompt when in a root shell
if [ ${EUID} -eq 0 ]; then
	PS1="\[$txtred\][\h\[\e[m\] \[$txtblu\]\w\[\e[m\]\[$txtred\]]# \[\e[m\]"
	#PS1="\[$txtred\][\t\[\e[m\] \[$txtblu\]\w\[\e[m\]\[$txtred\]]# \[\e[m\]"
else
	PS1="\[$txtgrn\][\h\[\e[m\] \[$txtblu\]\w\[\e[m\]\[$txtgrn\]]$ \[\e[m\]"
	#PS1="\[$txtgrn\][\t\[\e[m\] \[$txtblu\]\w\[\e[m\]\[$txtgrn\]]$ \[\e[m\]"
fi
PS2='> '
PS4='+ '

# Alias definitions.
# You may want to put all your additions into a separate file like
# /data/local/.bash_aliases or /sdcard/.bash_aliases, instead of adding them here directly.

if [ -f /data/local/.bash_aliases ]; then
	source /data/local/.bash_aliases
fi

if [ -f /sdcard/.bash_aliases ]; then
	source /sdcard/.bash_aliases
fi

