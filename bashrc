#if not running interactively, don't do anything
[ -z "$PS1" ] && return
# don't put duplicate lines in the history
# and don't put lines starting with space.
HISTCONTROL=ignoredups:ignorespace
# basic prompt
#PS1='\u@\h \W \$'
# color prompt
# - see https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[39m\]\u@\h:'; fi)\[\033[01;34m\] \W \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\\$\[\033[00m\] "

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="\[\033[00;36m\]\u@\h \[\033[01;34m\]\w\[\033[01;34m\]\$(parse_git_branch)\[\033[00m\] \[\033[00;36m\]$ \[\033[00m\]"

# show "[hh:mm] user@host:pwd" in xterm title bar
if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    # for Mac Terminal, omit "User@Users-MacBook-Air"
    # and preserve PROMPT_COMMAND set by /etc/bashrc.
    show_what_in_title_bar='"[$(date +%H:%M)] ${PWD/#$HOME/~}"'
    PROMPT_COMMAND='printf "\033]0;%s\007" '"$show_what_in_title_bar; $PROMPT_COMMAND"
else
#    show_what_in_title_bar='"[$(date +%H:%M)] ${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"'
     show_what_in_title_bar='" ${USER}@${PWD/#$HOME/~}"'

    case ${TERM} in
        xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
            PROMPT_COMMAND='printf "\033]0;%s\007" '$show_what_in_title_bar
            ;;
        screen)
            PROMPT_COMMAND='printf "\033_%s\033\\" '$show_what_in_title_bar
            ;;
    esac
fi
unset show_what_in_title_bar
# editor
export EDITOR=vim
# aliases & functions
case "$OSTYPE" in
*linux*)
    alias dmesg='dmesg --color'
    alias pacman='pacman --color=auto'
    alias ls='ls --color=auto'
    ;;
*darwin*)
    alias ls='ls -G'
    ;;
esac

alias ll='ls -alF'
alias l='ls -CF'
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
svndiff()     { svn diff "$@" | colordiff; }
svndiffless() { svn diff "$@" | colordiff | less -R; }

#bash unlimited history
HISTSIZE=
HISTFILESIZE=
# reset terminal, clear history. faster with 'tput' prefix
alias reset='tput reset'


export NVM_DIR="/Users/hanyidu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
