# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# set vi mode (Enabled in /etc/bash.bashrc)
set -o vi

# Disable <C-s> functionality for vim.surround
stty stop ""

###########################################################
# PATH
###########################################################
# Add ~/.local/bin to $PATH if it exists
if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add ~/.bin to $PATH if it exists
if [ -d "$HOME/.bin" ]; then
    PATH="$PATH:$HOME/.bin"
fi

###########################################################
# HISTORY
###########################################################
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# timestamp history entries
HISTTIMEFORMAT="%F %H:%M: "

# append to the history file, don't overwrite it
shopt -s histappend

###########################################################
#
###########################################################
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Configure less
export LESS=--mouse

###########################################################
#
###########################################################
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    if test -r ~/.dircolors; then
	eval "$(dircolors -b ~/.dircolors)" 
    else 
	eval "$(dircolors -b)"
    fi
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

###########################################################
# SSH 
###########################################################
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

# Source SSH settings, if applicable
#if [ -f "${SSH_ENV}" ]; then
#    . "${SSH_ENV}" > /dev/null
#    #ps ${SSH_AGENT_PID} doesn't work under cywgin
#    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi

# Start Keychain for SSH Authentication
if [ -f "$HOME/.ssh/gaming" ]; then
    eval "$(keychain --eval --quiet gaming)"
  elif [ -f "$HOME/.ssh/p50" ]; then
    eval "$(keychain --eval --quiet p50)"
  elif [ -f "$HOME/.ssh/x200" ]; then
    eval "$(keychain --eval --quiet x200)"
  elif [ -f "$HOME/.ssh/x230" ]; then
    eval "$(keychain --eval --quiet x230)"
fi

###########################################################
# GPG SSH
###########################################################
# Set SSH to use gpg-agent
#unset SSH_AGENT_PID
#if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
#fi

# Set GPG TTY
#export GPG_TTY
#GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
#gpg-connect-agent updatestartuptty /bye >/dev/null

###########################################################
# LOAD FILES
###########################################################
# Set custom PS1 prompt
if [ -f ~/.psone ]; then
    . ~/.psone;
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Function definitions.
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi
