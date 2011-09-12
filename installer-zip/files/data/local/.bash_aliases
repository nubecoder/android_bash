# /data/local/.bash_aliases
#

# aliases
#
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# NOTE:: !! not sure this works in android
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Set up some aliases to cover toolbox with the nice busybox equivalents of its commands
#
alias cat='busybox cat'
alias chmod='busybox chmod'
alias chown='busybox chown'
alias cp='busybox cp'
alias df='busybox df'
alias insmod='busybox insmod'
alias ls='busybox ls --color=auto'
alias l='busybox ls -CF --color=auto'
alias la='busybox ls -A --color=auto'
alias ll='busybox ls -AlF --color=auto'
alias ln='busybox ln'
alias lsmod='busybox lsmod'
alias mkdir='busybox mkdir'
alias more='busybox more'
alias mount='busybox mount'
alias mv='busybox mv'
alias rm='busybox rm'
alias rmdir='busybox rmdir'
alias rmmod='busybox rmmod'
alias su='su -c bash'
alias umount='busybox umount'
alias vi='busybox vi'

