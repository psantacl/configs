# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


export CLICOLOR=1
alias ls='ls -G'
alias ll='ls -lG'


# ===================================================================================
# ================       QUALITY OF LIFE FEATURES                    ================
# ===================================================================================
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# ===================================================================================
# ================           PROMPT APPEARANCE                       ================
# ===================================================================================
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# # set up git ps1
# if ! command -v __git_ps1 > /dev/null 2>&1
# then
#     echo "# Can't find __git_ps1. Not adding it to the prompt." >&2
#     __git_ps1() { return 0; }
# fi

# # only works if using __git_ps1 as a PROMPT_COMMAND
# # export GIT_PS1_SHOWCOLORHINTS=1
# export GIT_PS1_SHOWDIRTYSTATE=1
# export GIT_PS1_SHOWSTASHSTATE=1
# export GIT_PS1_SHOWUNTRACKEDFILES=1
# export GIT_PS1_SHOWUPSTREAM=auto
# export DEFAULT_PS1='\e[38;5;13m\n\t \e[38;5;3m \u \e[38;5;6m\w \e[38;5;11m$(__git_ps1)\e[m\n\$ '
# export PS1="$DEFAULT_PS1"


# ===================================================================================
# ================                   ALIASES                         ================
# ===================================================================================
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias auth-dev='eval $(aws-export-credentials --profile "talend-dev-cloud-admin" --env-export)'
alias auth-at='eval $(aws-export-credentials --profile "talend-at-admin" --env-export)'
alias auth-prod='eval $(aws-export-credentials --profile "talendcloud-admin" --env-export)'
alias ecr-login-aws-dev='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 054713022081.dkr.ecr.us-east-1.amazonaws.com'
alias unset-aws='unset AWS_SESSION_TOKEN AWS_CREDENTIALS_EXPIRATION AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID'
alias set-agent="echo 'export $(env | grep AUTH_SOCK)' > ~/.agent.env"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ===================================================================================
# ================                    INIT                           ================
# ===================================================================================
source ~/.profile
export PATH=$HOME/go/bin:/usr/local/spark/bin:$HOME/bin:$PATH
# echo "export $(env | grep AUTH_SOCK)" > ~/.agent.env

# ===================================================================================
# ================                    FUNCTIONS                      ================
# ===================================================================================
# add functions here
